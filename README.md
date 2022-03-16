# Projeto Computação Móvel - iQueChumbei

## 🎯 Flutter / Dart / Android Studio
## 👨‍🎓 Paulo Pinto - a21906966

Projeto para avaliar o desenvolvimento de uma aplicação híbrida de registo de pesos (CRUD) e estatísticas (sem armazenamento de dados).

***

## Funcionalidades
### Criar registos (Create)


O utilizador pode criar o registo à sua vontade, desde que os dados introduzidos no campo do peso sejam um número e que as observações estejam entre 100 e 200 caracteres (for some reason). O requisito de duas casas decimais para o peso é feito posteriormente ao input do utilizador, portanto o utilizador pode escrever por exemplo `65.34341241242`, mas o valor que vai ficar registado na ocorrência terá apenas 2 casas decimais, neste caso `65.34`.


### Consultar registo (Read)


### Listar registos (Read)

Criei um ecrã que lista os registos todos, do mais recente (cima) até ao mais antigo (baixo). Os símbolos de balança indicam quais dos registos podem ser editados/eliminados (de acordo com a regra dos últimos 7 dias).


### Editar registos (Update)

Dando *swipe* da esquerda para a direita e aceitando o *prompt*, somos dirigidos para a página de edição do registo em que demos *swipe*, caso este tenha menos que 7 dias. 

### Eliminar registos (Delete)

Dando *swipe* da direita para a esquerda e aceitando o *prompt*, eliminamos o registo em que demos *swipe*, caso este tenha menos que 7 dias.

### Dashboard

Decidi tornar a média e a variância (dos 7 e 30 dias) numa tabela. Calculei a variância para o peso e também para como a pessoa se sentia (disposição). Estou satisfeito com o estado da Dashboard, julgo estar simples e eficaz a comunicar os dados pedidos.

### Gráfico Dashboard

Dei uso à biblioteca [fl_chart](https://pub.dev/packages/fl_chart) para fazer o gráfico, mas admito que foi complicado, principalmente entender a forma como ia passar os dados e tentar passar também as datas dos registos (que no final não consegui).

### Navegabilidade

Dada a simplicidade da aplicação, a principal forma para navegar é através dos `floatingActionButtons` que se encontram no canto inferior direito da aplicação. Estes botões permitem que, em qualquer ecrã, o utilizador possa aceder ao ecrã que pretende ir com apenas um *click*.


Devido à natureza dos Widgets utilizados, a aplicação corre bem em qualquer resolução (realista). Exemplos:


<!--  ![graph image](/assets/graph_1.png) -->
<p align="center">
  <img src="/assets/graph_1.png" />
</p>

***

## Autoavaliação

Tendo em conta os requisitos que cumpri e a respetiva tabela de cotações, prevejo que a minha nota seja no máximo um 18.

Gostaria de ter investido mais na navegabilidade e na estética da aplicação, acho que ficou muito *barebones*, devido ao foco dados à conclusão dos outros requisitos.

Também gostaria de ter feito testes unitários, mas infelizmente não tive tempo para entender como se faziam corretamente, e sendo apenas os últimos 2 valores decidi ficar por aqui.
