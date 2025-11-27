# language: pt
@javascript
Funcionalidade: Acessibilidade
  Como um usuário com deficiência
  Eu quero navegar no site sem barreiras
  Para que eu possa usar todas as funcionalidades

  Cenário: Verificar acessibilidade na página inicial
    Dado que eu estou na página inicial
    Então a página não deve ter violações de acessibilidade (WCAG 2.1 AA)

  Cenário: Verificar acessibilidade na página de login
    Dado que eu acesso qualquer página pública
    Então a página não deve ter violações de acessibilidade (WCAG 2.1 AA)
