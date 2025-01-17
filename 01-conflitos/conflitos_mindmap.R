library(DiagrammeR)
library(DiagrammeRsvg)
library(rsvg)

# Definir o código DOT do gráfico
graph_code <- "
  digraph example {
    graph [layout = dot, rankdir = TB]

    # Definir os nós principais
    node [shape = circle]
    A -> B -> C

    # Adicionar múltiplos subnodes a B
    B -> B_sub1 [label = 'Subnode 1', style = dashed, color = gray]
    B -> B_sub2 [label = 'Subnode 2', style = dashed, color = gray]

    # Customizar os subnodes
    B_sub1 [shape = rectangle, style = filled, fillcolor = lightblue]
    B_sub2 [shape = rectangle, style = filled, fillcolor = lightgreen]
  }
"

# Renderizar e visualizar o gráfico no RStudio
DiagrammeR::grViz(graph_code)

# Gerar SVG a partir do gráfico
svg_output <- DiagrammeRsvg::export_svg(DiagrammeR::grViz(graph_code))

# Salvar como PNG de alta resolução
rsvg_png(charToRaw(svg_output), "graph_highres.png", width = 8000, height = 8000)

