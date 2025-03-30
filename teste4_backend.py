from flask import Flask, request, jsonify
from flask_cors import CORS
import pandas as pd
import numpy as np

# Criação do app Flask
app = Flask(__name__)

# Habilitação do CORS
CORS(app)

# Carrega o arquivo CSV
try:
    df = pd.read_csv('Relatorio_cadop.csv', encoding='utf-8', sep=';')
except FileNotFoundError:
    exit()
except Exception as e:
    print(f'Erro ao carregar o CSV: {e}')
    exit()

# Função para buscar os registros relevantes
def buscar_operadoras(termo):
    termo = termo.lower()

    # Atribuir pontuações com base na relevância
    df['pontuacao'] = df.apply(lambda row: 
        (5 if termo in str(row['Razao_Social']).lower() else 0) +
        (5 if termo in str(row['Nome_Fantasia']).lower() else 0) +
        (3 if termo in str(row['CNPJ']).lower() else 0) +
        (2 if termo in str(row['Cidade']).lower() else 0) +
        (1 if termo in str(row['Representante']).lower() else 0),
        axis=1
    )

    # Filtra os registros dependendo do texto buscado
    resultados = df[df['pontuacao'] > 0].sort_values(by='pontuacao', ascending=False)
    return resultados

# Rota para busca
@app.route('/buscar', methods=['GET'])
def buscar():
    termo = request.args.get('termo', '')
    pagina = int(request.args.get('pagina', 1))
    tamanho = int(request.args.get('tamanho', 10))

    if not termo:
        return jsonify({"error": "Por favor, forneça um termo de busca."})
    
    # Realiza busca
    resultados = buscar_operadoras(termo)
    if resultados.empty:
        return jsonify({"message": "Nenhum registro encontrado."})
    
    # Paginação

    inicio = (pagina - 1) * tamanho
    fim = inicio + tamanho
    
    # Converte os resultados para JSON
    registros = resultados.replace({np.nan:None}).to_dict(orient='records')[inicio:fim]

    return jsonify({"pagina":pagina, "resultados": registros})

# Rota para tratar erros não previstos
@app.errorhandler(500)
def erro_interno(error):
    return jsonify({"error": "Ocorreu um erro interno. Tente novamente."})

if __name__ == '__main__':
    app.run(debug=True)