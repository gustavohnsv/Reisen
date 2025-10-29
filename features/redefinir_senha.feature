# language: pt
# encoding: utf-8

Funcionalidade: Ter a Opção de Redefinir a Senha
  Como um usuário que esqueceu a senha
  Quero poder solicitar a redefinição da minha senha e definir uma nova
  Para recuperar acesso à minha conta de forma segura

  Cenário: Solicitar redefinição de senha e criar nova senha com sucesso
    Dado que eu estou na página de login
    E eu clico em "Esqueci minha senha"
    Quando eu informo o e-mail "usuario@example.com" e envio a solicitação
    Então o sistema envia um e-mail para "usuario@example.com" contendo um link de redefinição com um token válido
    Quando eu clico no link de redefinição recebido e acesso a página de nova senha
    E eu informo a nova senha "Senha@123" e confirmo com "Senha@123"
    E eu submeto a nova senha
    Então a senha do usuário é atualizada
    E eu sou redirecionado para a página de login com a mensagem "Senha redefinida com sucesso"
    E o token de redefinição é invalidado
