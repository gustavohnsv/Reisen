# language: pt
# encoding: utf-8

Funcionalidade: Controlar gastos
  Para controlar o orçamento da viagem

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
    E que tenho um roteiro chamado "Viagem para Paris"
    E que tenho um item do roteiro chamado "Visitar a Torre Eiffel"
    E estou logado
    E que estou no meu perfil

  Cenário: Adicionar um gasto da viagem
    Dado que eu estou na página de perfil
    E que vejo um roteiro chamado "Viagem para Paris"
    Quando clicar no link "Viagem para Paris"
    Então devo ser redirecionado para o roteiro "Viagem para Paris"
    Dado que eu estou na página do roteiro "Viagem para Paris"
    Quando clicar em "Adicionar Novo Gasto"
    E preencher o campo com ID "new-spend-amount" com "14.99"
    E preencher o campo com ID "new-spend-date" com ""
    E selecionar o campo com ID "new-spend-category" com "Transporte"
    E preencher o campo com ID "new-spend-quantity" com "2"
    E clicar em "Adicionar Gasto"
    Então devo receber OK

  Cenário: Remover um gasto da viagem
    Dado que eu estou na página de perfil
    E que vejo um roteiro chamado "Viagem para Paris"
    Quando clicar no link "Viagem para Paris"
    Então devo ser redirecionado para o roteiro "Viagem para Paris"
    Dado que eu estou na página do roteiro "Viagem para Paris"
    Quando clicar em "Gerenciar Gastos do Item"
    E clicar em "Apagar"
    Então devo receber OK
