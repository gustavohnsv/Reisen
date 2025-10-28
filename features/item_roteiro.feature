# language: pt
# encoding: utf-8

Funcionalidade: Item no roteiro
  Para que seja possível adicionar, editar e excluir itens do roteiro

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

  Cenário: Adicionar um item no roteiro
    Dado que eu estou na página de perfil
    E que vejo um roteiro chamado "Viagem para Paris"
    Quando clicar no link "Viagem para Paris"
    Então devo ser redirecionado para o roteiro "Viagem para Paris"
    Dado que eu estou na página do roteiro "Viagem para Paris"
    Quando clicar em "Adicionar Novo Item"
    E preencher o campo com ID "new-item-title" do item do roteiro "Viagem para Paris" com "Experimentar croissant"
    E preencher o campo com ID "new-item-description" do item do roteiro "Viagem para Paris" com "Comprar um croissant para cada integrante"
    E preencher o campo com ID "new-item-location" do item do roteiro "Viagem para Paris" com "Paris"
    E preencher o campo com ID "new-item-date-time-start" do item do roteiro "Viagem para Paris" com ""
    E preencher o campo com ID "new-item-estimated-cost" do item do roteiro "Viagem para Paris" com "14.99"
    E clicar em "Adicionar Item"
    Então devo ver o item "Experimentar croissant" na página do roteiro "Viagem para Paris" com o seu ID

  Cenário: Editar o nome do item do roteiro
    Dado que eu estou na página de perfil
    E que vejo um roteiro chamado "Viagem para Paris"
    Quando clicar no link "Viagem para Paris"
    Então devo ser redirecionado para o roteiro "Viagem para Paris"
    Dado que eu estou na página do roteiro "Viagem para Paris"
    E que vejo um item do roteiro chamado "Visitar a Torre Eiffel" com o seu ID
    Quando preencher o campo do item do roteiro com ID "edit-item-title" com o nome "Visitar a Torre Eiffel" para "Visitar o Museu do Louvre"
    E clicar em "check"
    Então devo ver o item "Visitar o Museu do Louvre" na página do roteiro "Viagem para Paris" com o seu ID

  Cenário: Remover um item do roteiro
    Dado que eu estou na página de perfil
    E que vejo um roteiro chamado "Viagem para Paris"
    Quando clicar no link "Viagem para Paris"
    Então devo ser redirecionado para o roteiro "Viagem para Paris"
    Dado que eu estou na página do roteiro "Viagem para Paris"
    E que vejo um item do roteiro chamado "Visitar a Torre Eiffel" com o seu ID
    Quando clicar em "close"
    Então não devo ver o item "Visitar a Torre Eiffel" na página do roteiro "Viagem para Paris" com o seu ID