# language: pt
Funcionalidade: Validações de foto de perfil

  Como usuário
  Para evitar uploads inválidos
  Quero ver erros ao enviar arquivos não-imagem ou muito grandes

  Contexto:
    Dado que estou logado como "kaique"
    E acesso a página de edição de perfil

  Cenário: Tentar enviar um arquivo que não é imagem
    Quando eu envio um arquivo não-imagem
    E salvo as alterações
    Então devo ver uma mensagem de erro indicando que o arquivo deve ser uma imagem

  Cenário: Tentar enviar uma imagem muito grande
    Quando eu envio uma imagem grande simulada
    E salvo as alterações
    Então devo ver uma mensagem de erro indicando que o arquivo é muito grande
