# language: pt
# encoding: utf-8

Funcionalidade: Acesso roteiro compartilhado como convidado
    Para não me perder no roteiro e nem precisar consultar o lìder do grupo, sem precisar logar no sistema

    # Cenário: (Feliz ou triste) Indica o comportamento esperado da funcionalidade
    # Dado: Estado atual do programa
    # E: Extensão de comandos
    # Quando: Ação que o usuário irá fazer
    # Então: Resultado esperado da ação

  Contexto:
    Dado que existe um token para o roteiro "Viagem para Paris" de "John Doe"

  Cenário: Acesso ao roteiro sem login
    Dado que eu estou na página principal e não tenho uma conta
    Quando eu visitar o link para o roteiro de "John Doe"
    Então devo ser redirecionado para a tela do roteiro de "John Doe"

  Cenário: Acesso ao roteiro sem login com token incorreto
    Dado que eu estou na página principal e não tenho uma conta
    Quando eu visitar o link para o roteiro de "John Doe" sem o token
    Então devo ser redirecionado para a página principal
