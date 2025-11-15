# language: pt
# encoding: utf-8

Funcionalidade: Acessar roteiro compartilhado
    Para não me perder no roteiro e nem precisar consultar o lìder do grupo

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
      E estou logado
      E que estou no meu perfil

    Cenário: Acessar roteiro logado
      Dado que eu estou na página de perfil
      E que vejo um roteiro chamado "Viagem para Paris"
      Quando clicar no link "Viagem para Paris"
      Então devo ser redirecionado para o roteiro "Viagem para Paris"