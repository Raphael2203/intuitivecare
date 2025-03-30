import pdfplumber
import pandas as pd
import zipfile as zip
import os

# Caminho do PDF extraído
pdf_path = "anexos/Anexo_I.pdf"
csv_path = "Rol_Procedimentos.csv"
zip_path = f"Teste_Raphael.zip"

# Extrair dados do PDF
def extrair_dados_pdf(pdf_path):
    dados_tabela = [] # Lista para armazenar os dados extraídos
    with pdfplumber.open(pdf_path) as pdf:
        for pagina in pdf.pages:
            tabelas = pagina.extract_tables() # Extrair tabelas da página
            for tabela in tabelas:
                for linha in tabela: # Adicionar cada linha à lista
                    dados_tabela.append(linha)
    return dados_tabela

# Criar o arquivo CSV
def criar_tabela_csv(dados, csv_path):
    # Criar DataFrame com os dados extraídos
    colunas = ["PROCEDIMENTO", "RN (alteração)", "VIGÊNCIA", "OD", "AMB", 
               "HCO", "HSO", "REF", "PAC", "DUT", "SUBGRUPO", "GRUPO", "CAPÍTULO"]
    if len(dados[0]) != len(colunas): # Validação
        print('Erro: O número de colunas extraídas não corresponde ao esperado')
        return
    
    df = pd.DataFrame(dados, columns=colunas)

    # Remover linhas inválidas ou vazias
    df = df.dropna()

    # Substituir abreviações OD e AMB
    df["OD"] = df["OD"].replace({
        "OD": "Seg. Odontológica"
    })

    df["AMB"] = df["AMB"].replace({
        "AMB": "Seg. Ambulatorial"
    })

    # Salvar CSV
    df.to_csv(csv_path, index=False)
    print(f'CSV salvo em: {csv_path}')

# Compactar o CSV em ZIP
def compactar_csv(csv_path, zip_path):
    with zip.ZipFile(zip_path, "w") as zipf:
        zipf.write(csv_path, arcname=os.path.basename(csv_path))
    print(f'Compactação concluída. Arquivo ZIP salvo em: {zip_path}')

# Executar o processo
if os.path.exists(pdf_path): # Valida se o PDF existe
    dados_extraidos = extrair_dados_pdf(pdf_path)
    criar_tabela_csv(dados_extraidos, csv_path)
    compactar_csv(csv_path, zip_path)
    print('Processo concluído com sucesso!')
else:
    print(f'O arquivo {pdf_path} não foi encontrado. Verifique e tente novamente.')


