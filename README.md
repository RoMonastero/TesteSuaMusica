# Bem vindo ao nosso Teste de Desenvolvimento Mobile FLUTTER!

A proposta desse teste é conhecer um pouco mais sobre como você desenvolve, o quão bem você conhece o flutter/dart, desenvolvimento em geral e as melhores práticas de arquitetura de software que você conhece.

## Descrição do projeto

Como um desenvolvedor Mobile, você recebeu uma tarefa para desenvolver um aplicativo para os amantes de jogos.
A primeira versão do aplicativo (MVP) vai ser bem simples e limitada, apenas para mostrar a lista dos jogos pela plataforma, mostrando os detalhes de cada jogo em uma tela separada.

## Requisitos Funcionais

Você vai desenvolver duas telas:

**Lista de Jogos**: O usuário deve estar apto à escolher a plataforma que deseja no `top bar`, o qual vai carregar a lista de jogos na tela abaixo. Na lista de jogos deve conter o nome e a imagem do jogo.

**Detalhes do Jogo**: Quando selecionar o jogo na lista, o usuário será redirecionado a tela de detalhes do jogo, onde as informações de imagem, nome, genero, plataformas desponiveis e descrição do jogo irão aparecer.

**Cache local** Nossos usuário precisam dos dados offline, então todas as telas navegadas devem ser salvas num sqlite, para podermos voltar e navegar em modo avião.

![Lista do Jogo](images/games.png?raw=true "Games List")

![Detalhes do jogo](images/game_detail.png?raw=true "Game Detail")

## Requerimentos tecnicos

Nosso aplicatido ficticio deve crescer rápido, então deve ser uma solução que aplique uma arquitetura que você considere consistente e garanta que o código seja escalavel.

### API

Use a IGDB API para buscar os dados sobre os jogos:
https://api.igdb.com/

### Entregaveis:

Por favor siga os passos abaixo:

1. Crie o repositório no BitBucket, GitHub or GitLab;

2. Adicione imagens do app numa pasta no projeto chamada "screenshots";

3. Inclua um arquivo README com as instruções para build do projeto;

4. Uma vez que tiver terminado o trabalho, me envie o link do repositório, com acesso de leitura.

### Linguagem e Bibliotecas obrigatórias:

Para esse projeto vamos utilizar a linguagem flutter/dart.

Para gerenciamento de estado, BLOC.

Para injeção de dependencias ChangeNotifier (Provider).

Adicionar teste unitário.

### Diferenciais:

ORM MOOR/DRIFT.

Teste de widget.

Teste de integração.

Usar os temas com o darkMode.

Utilizar principios do SOLID.


Boa Sorte, e bons estudos! ;)