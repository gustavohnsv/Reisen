# language: pt
# encoding: utf-8

Funcionalidade: Entrar no sistema
  Para que eu tenha acesso aos recursos para planejar a viagem (roteiro, checklist, etc)

    # Cenário: (Feliz ou triste) Indica o comportamento esperado da funcionalidade
    # Dado: Estado atual do programa
    # E: Extensão de comandos
    # Quando: Ação que o usuário irá fazer
    # Então: Resultado esperado da ação

    Contexto:
      Dado que meu nome é "John Doe"
      E que meu email é "johndoe@example.com"
      E que minha senha é "password"

    Cenário: Criar conta
      Dado que eu estou na página principal e não tenho uma conta
      Quando clicar em "Sign Up"
      Então devo ser redirecionado para a tela de cadastro
      Quando preencher o campo "Name" com "John Doe"
      E preencher o campo "Email" com "johndoe@example.com"
      E preencher o campo "Password" com "password"
      E preencher o campo "Password confirmation" com "password"
      E clicar em "Sign up"
      Então minha conta deve ser criada
      E devo ser redirecionado para a tela de perfil

    Cenário: Entrar na conta
      Dado que eu estou na página principal e tenho uma conta
      Quando clicar em "Login"
      Então devo ser redirecionado para a tela de login
      Quando preencher o campo "Email" com "johndoe@example.com"
      E preencher o campo "Password" com "password"
      E clicar em "Log in"
      Então devo ser redirecionado para a tela de perfil

    Cenário: Entrar na conta pela URL sem login
      Dado que eu estou na página principal e não tenho uma conta
      Quando eu tento visitar a tela de perfil
      Então devo ser redirecionado para a tela de login