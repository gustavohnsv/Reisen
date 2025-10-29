# language: pt
# encoding: utf-8

Funcionalidade: Item na checklist
  Para que seja possível adicionar, editar e excluir itens da checklist

    # Cenário: (Feliz ou triste) Indica o comportamento esperado da funcionalidade
    # Dado: Estado atual do programa
    # E: Extensão de comandos
    # Quando: Ação que o usuário irá fazer
    # Então: Resultado esperado da ação

  Contexto:
    Dado que meu nome é "John Doe"
    E que meu email é "johndoe@example.com"
    E que minha senha é "password"
    E que eu tenho uma conta
    E que tenho uma checklist chamada "Preparaçao para a viagem"
    E que tenho um item da checklist chamado "Fazer compras"
    E estou logado
    E que estou no meu perfil

  Cenário: Adicionar um item na checklist
    Dado que eu estou na página de perfil
    E que vejo uma checklist chamada "Preparaçao para a viagem"
    Quando clicar no link "Preparaçao para a viagem"
    Então devo ser redirecionado para a checklist "Preparaçao para a viagem"
    Dado que eu estou na página da checklist "Preparaçao para a viagem"
    Quando preencher o campo com ID "new-item-description" do item da checklist "Preparacao para a viagem" com "Organizar as malas"
    E clicar em "add"
    Então devo ver o item "Organizar as malas" na pagina da checklist "Preparacao para a viagem" com o seu ID

  Cenário: Editar o nome do item da checklist
    Dado que eu estou na página de perfil
    E que vejo uma checklist chamada "Preparaçao para a viagem"
    Quando clicar no link "Preparaçao para a viagem"
    Então devo ser redirecionado para a checklist "Preparaçao para a viagem"
    Dado que eu estou na página da checklist "Preparaçao para a viagem"
    E que vejo um item de checklist chamado "Fazer compras" com o seu ID
    Quando preencher o campo do item da checklist com ID "edit-item-description" com o nome "Fazer compras" para "Fazer mais compras"
    E clicar em "check"
    Entao devo ver o item "Fazer mais compras" na pagina da checklist "Preparacao para a viagem" com o seu ID

  Cenário: Marcar o item da checklist
    Dado que eu estou na página de perfil
    E que vejo uma checklist chamada "Preparaçao para a viagem"
    Quando clicar no link "Preparaçao para a viagem"
    Então devo ser redirecionado para a checklist "Preparaçao para a viagem"
    Dado que eu estou na página da checklist "Preparaçao para a viagem"
    E que vejo um item de checklist chamado "Fazer compras" com o seu ID
    E sua caixa de seleçao nao esta marcada
    Quando clicar no checkbox do item da checklist chamado "Fazer compras"
    Entao sua caixa de seleçao deve estar marcada

  Cenário: Remover um item da checklist
    Dado que eu estou na página de perfil
    E que vejo uma checklist chamada "Preparaçao para a viagem"
    Quando clicar no link "Preparaçao para a viagem"
    Então devo ser redirecionado para a checklist "Preparaçao para a viagem"
    Dado que eu estou na página da checklist "Preparaçao para a viagem"
    E que vejo um item de checklist chamado "Fazer compras" com o seu ID
    Quando clicar em "close"
    Então nao devo ver o item "Fazer compras" na pagina da checklist "Preparacao para a viagem" com o seu ID