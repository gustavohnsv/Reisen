# language: pt
# encoding: utf-8
@javascript

Funcionalidade: Excluir conta
  Como usuário autenticado
  Para controlar meus dados pessoais
  Quero excluir minha conta quando desejar

  Cenário: Usuário exclui a própria conta
    Dado que estou autenticado e na página de edição do meu perfil
    Quando confirmo a exclusão da conta
    Então devo ver a confirmação de conta excluída
    E minha conta deve ser removida do sistema
