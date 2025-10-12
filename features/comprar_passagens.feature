# language: pt
# encoding: utf-8

Funcionalidade: Comprar passagens
    Para facilitar a compra das passagens

    # Cenário: (Feliz ou triste) Indica o comportamento esperado da funcionalidade
    # Dado: Estado atual do programa
    # E: Extensão de comandos
    # Quando: Ação que o usuário irá fazer
    # Então: Resultado esperado da ação

    # nesse caso, deveria conter uma lista de companhias?
    # funcionalidade deve ser pensada em usuário logado ou deslogado?

    Contexto:
      Dado que meu nome é "John Doe"
      E que meu email é "johndoe@example.com"
      E que minha senha é "password"
      E que eu tenho uma conta
      E que tenho um roteiro chamado "Viagem para Paris"
      E estou logado
      E que estou no meu perfil

    @mock_airlines
    Cenário: Redirecionado com sucesso para o site da companhia
        Dado que eu estou na página de perfil
        E que vejo um roteiro chamado "Viagem para Paris"
        Quando clicar no link "Viagem para Paris"
        Então devo ser redirecionado para o roteiro "Viagem para Paris"
        Dado que existem companhias áreas com links de compra disponíveis
        Quando eu clico no link da companhia "Latam"
        Então a nova aba da companhia "Latam" deve ser aberta e ter o URL validado

    #@mock_airlines
    #Cenário: Falha no redirecionamento para o site da companhia

    #@mock_airlines
    #Cenário: Tentativa de comprar passagens deslogado
