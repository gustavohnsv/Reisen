# language: pt
# encoding: utf-8

Funcionalidade: Criar roteiro
  Para que eu possa organizar as minhas viagens

    # Cenário: (Feliz ou triste) Indica o comportamento esperado da funcionalidade
    # Dado: Estado atual do programa
    # E: Extensão de comandos
    # Quando: Ação que o usuário irá fazer
    # Então: Resultado esperado da ação

    Contexto:
      Dado que meu nome é "John Doe"
      E que meu email é "johndoe@example.com"
      E que minha senha é "password"
      E que quero criar um roteiro chamado "Viagem para Paris"
      E que eu tenho uma conta e estou no meu perfil

    Cenario: Criar roteiro
      Dado que eu estou na página de perfil
      Quando clicar em "Novo roteiro"
      Então devo ser redirecionado para a tela de criação de roteiro
      Quando preencher o campo "Title" com "Viagem para Paris"
      E clicar em "Criar roteiro"
      Então meu roteiro deve ser criado
      E devo ser redirecionado para a tela do novo documento