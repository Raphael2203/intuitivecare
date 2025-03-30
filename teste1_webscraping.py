import zipfile
import requests
import os
from bs4 import BeautifulSoup

# Acessar o site
url = "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos"
response = requests.get(url)
response.raise_for_status() #Verifica erros na requisição

# Encontrar os links para os PDFs (Anexos I e II)
soup = BeautifulSoup(response.text, "html.parser")
pdf_links = [a['href'] for a in soup.find_all('a', href=True) if ".pdf" in a['href']]


#Verificar os PDFs desejados
if not any("anexo_i_rol_2021rn" in link.lower() or "anexo_ii_dut_2021_rn" in link.lower() for link in pdf_links):
        print("Nenhum link correspondente aos anexos foi encontrado.\n"
        " Verifique o site ou os critérios de filtragem.")
else:
    # Baixar os PDFs específicos
    os.makedirs("anexos", exist_ok=True) # Pasta para armazenar os PDFs

    for link in pdf_links:
        if "anexo_i_rol_2021rn" in link.lower(): 
            try:
                pdf_response = requests.get(link)
                pdf_response.raise_for_status() # Verifica os erros no download
                with open (os.path.join("anexos", "Anexo_I.pdf"), "wb") as pdf_file: # Renomear arquivo para Anexo_I
                    pdf_file.write(pdf_response.content)
            except requests.exceptions.RequestException as e:
                print(f'Erro ao baixar {link}: {e}')
        elif "anexo_ii_dut_2021_rn" in link.lower():
            try:
                pdf_response = requests.get(link)
                pdf_response.raise_for_status() # Verifica os erros no download
                with open (os.path.join("anexos", "Anexo_II.pdf"), "wb") as pdf_file: # Renomear arquivo para Anexo_II
                    pdf_file.write(pdf_response.content)
            except requests.exceptions.RequestException as e:
                print(f'Erro ao baixar {link}: {e}')

    # Compacatr os PDFs em um único arquivo ZIP
    if not os.listdir("anexos"):
        print("Nenhum arquivo para compactar")
    else:
        # Compactar os PDFs em um único arquivo ZIP
        zip_path = os.path.join(os.getcwd(), "anexos.zip")
        with zipfile.ZipFile(zip_path, "w") as zipf:
            for root, _, files in os.walk("anexos"):
                for file in files:
                    zipf.write(os.path.join(root, file), file)
        print('Compactação concluída.\n'
        'Download e compactação concluídos com sucesso.')