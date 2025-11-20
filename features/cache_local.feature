# language: pt
# encoding: utf-8

Funcionalidade: Cache local do roteiro
  Como usuário não-autenticado
  Para não perder meus dados ao fechar o roteiro rápido
  Quero manter meus dados salvos localmente no browser

  Contexto:
    Dado que estou na página inicial

  Cenário: Acessar o roteiro rápido
    Quando acesso o roteiro rápido
    Então devo ver o formulário de planejamento local
