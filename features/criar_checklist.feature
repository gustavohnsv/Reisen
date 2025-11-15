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
    E que quero criar uma checklist chamada "Minha rotina"
    E que eu tenho uma conta
    E estou logado
    E que estou no meu perfil

  Cenario: Criar roteiro
    Dado que eu estou na página de perfil
    Quando clicar em "Nova checklist"
    Então devo ser redirecionado para a tela de criação de checklist
    Quando preencher o campo "Title" com "Minha rotina"
    E clicar em "Criar checklist"
    Então minha checklist deve ser criada
    E devo ser redirecionado para a tela da nova checklist