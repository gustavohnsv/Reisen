# language: pt
# encoding: utf-8

Funcionalidade: Ver rota no Google Maps
  Para que seja possível visualizar todos os itens do roteiro como waypoints no Google Maps

  Contexto:
    Dado que meu nome é "John Doe"
    E que meu email é "johndoe@example.com"
    E que minha senha é "password"
    E que eu tenho uma conta
    E que tenho um roteiro chamado "Viagem para Paris"
    E estou logado
    E que estou no meu perfil

  Cenário: Visualizar rota com múltiplos itens no Google Maps
    Dado que eu estou na página de perfil
    E que vejo um roteiro chamado "Viagem para Paris"
    Quando clicar no link "Viagem para Paris"
    Então devo ser redirecionado para o roteiro "Viagem para Paris"
    Dado que eu estou na página do roteiro "Viagem para Paris"
    E que tenho um item do roteiro chamado "Restaurante A" com localização "Paris, França"
    E que tenho um item do roteiro chamado "Museu B" com localização "Lyon, França"
    E que tenho um item do roteiro chamado "Hotel C" com localização "Marselha, França"
    Então devo ver um botão "Ver Rota no Google Maps" na sidebar
    E devo ser redirecionado para uma URL do Google Maps contendo os waypoints

  Cenário: Botão não aparece quando não há itens com localização
    Dado que eu estou na página de perfil
    E que vejo um roteiro chamado "Viagem para Paris"
    Quando clicar no link "Viagem para Paris"
    Então devo ser redirecionado para o roteiro "Viagem para Paris"
    Dado que eu estou na página do roteiro "Viagem para Paris"
    E que não há itens no roteiro
    Então não devo ver um botão "Ver Rota no Google Maps" na sidebar

  Cenário: Botão não aparece quando há apenas itens sem localização
    Dado que eu estou na página de perfil
    E que vejo um roteiro chamado "Viagem para Paris"
    Quando clicar no link "Viagem para Paris"
    Então devo ser redirecionado para o roteiro "Viagem para Paris"
    Dado que eu estou na página do roteiro "Viagem para Paris"
    E que tenho um item do roteiro chamado "Item sem localização" sem localização
    Então não devo ver um botão "Ver Rota no Google Maps" na sidebar

