# language: pt
Funcionalidade: Foto de perfil

  Como usuário
  Para personalizar mais minha experiência
  Quero escolher minha própria foto de perfil

  Contexto:
    Dado que estou logado como "kaique"
    E acesso a página de edição de perfil

  Cenário: Fazer upload de foto de perfil com sucesso
    Quando eu envio uma imagem de perfil
    E salvo as alterações
    Então devo ver uma mensagem de sucesso
    E devo ver a pré-visualização da minha foto de perfil na página
