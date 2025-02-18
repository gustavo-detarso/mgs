import os
from xml.etree import ElementTree as ET

def adicionar_fundo_preto(svg_path):
    """
    Adiciona um elemento <rect> com fundo preto no início do arquivo SVG.

    :param svg_path: Caminho do arquivo SVG a ser processado.
    """
    try:
        # Carregar o SVG como um XML
        tree = ET.parse(svg_path)
        root = tree.getroot()

        # Obter as dimensões do SVG
        width = root.attrib.get("width", "100%")
        height = root.attrib.get("height", "100%")

        # Adicionar o elemento <rect> com fundo preto
        rect = ET.Element("rect", {
            "width": width,
            "height": height,
            "fill": "black",
            "x": "0",
            "y": "0"
        })
        root.insert(0, rect)  # Insere o <rect> como o primeiro elemento

        # Salvar o arquivo atualizado
        tree.write(svg_path, encoding="utf-8", xml_declaration=True)
        print(f"Fundo preto adicionado ao arquivo: {svg_path}")
    except ET.ParseError:
        print(f"Erro ao processar o arquivo: {svg_path}. O arquivo pode não ser um SVG válido.")
    except Exception as e:
        print(f"Ocorreu um erro ao processar {svg_path}: {e}")

def processar_svgs_em_diretorio(diretorio):
    """
    Processa todos os arquivos SVG em um diretório, adicionando fundo preto.

    :param diretorio: Caminho do diretório contendo os arquivos SVG.
    """
    # Verificar se o diretório existe
    if not os.path.isdir(diretorio):
        print(f"Diretório não encontrado: {diretorio}")
        return

    # Obter todos os arquivos SVG no diretório
    arquivos_svg = [f for f in os.listdir(diretorio) if f.endswith(".svg")]

    if not arquivos_svg:
        print("Nenhum arquivo SVG encontrado no diretório.")
        return

    # Processar cada arquivo SVG
    for arquivo in arquivos_svg:
        caminho_svg = os.path.join(diretorio, arquivo)
        adicionar_fundo_preto(caminho_svg)

    print("Processamento concluído. Todos os arquivos SVG foram atualizados.")

# Solicitar o diretório ao usuário
diretorio_svg = input("Digite o caminho do diretório contendo os arquivos SVG: ").strip()

# Processar os SVGs no diretório informado
processar_svgs_em_diretorio(diretorio_svg)
