# language: pt
# encoding: utf-8

Funcionalidade: Customização do perfil do usuário

  Como usuário
  Para me diferenciar do restante do meu grupo
  Quero customizar meu nome de usuário e perfil

  Contexto:
    Dado que estou logado como "kaique"
    E acesso a página de edição de perfil

  Cenário: Alterar com sucesso o nome de usuário e perfil
    Quando altero meu nome de usuário para "kaique_custom"
    E salvo as alterações
    Então devo ver uma mensagem de sucesso
    E meu nome de usuário deve ser exibido como "kaique_custom"

  Cenário: Tentar salvar nome de usuário em branco
    Quando apago meu nome de usuário
    E salvo as alterações
    Então devo ver uma mensagem de erro indicando que o nome de usuário não pode ser em branco

  Cenário: Tentar salvar nome de usuário já existente
    Dado que já existe um usuário com nome "usuario123"
    Quando altero meu nome de usuário para "usuario123"
    E salvo as alterações
    Então devo ver uma mensagem de erro indicando que o nome de usuário já está em uso