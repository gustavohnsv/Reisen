# language: pt
# encoding: utf-8


Funcionalidade: Edição colaborativa do documento de viagem
  Para que o planejamento seja colaborativo
  Como membro de um grupo de viagem
  Quero que o grupo todo consiga editar o documento

  Contexto:
    Dado que existe um documento de planejamento intitulado "Roteiro de Paris" com a seção "Dia 1 - Chegada"

  Cenário: Membro do grupo edita uma seção com sucesso
    Dado que existe um usuário "bob" membro do documento
    Quando "bob" abre o documento
    E eu edito a seção "Dia 1 - Chegada" com o texto "Chegar e descansar"
    E eu salvo as alterações
    Então eu devo ver a mensagem "Documento salvo com sucesso"
    E a seção "Dia 1 - Chegada" deve conter "Chegar e descansar"

  Cenário: Usuário não membro não consegue editar
    Dado que existe um usuário "externo" que não pertence ao documento
    Quando "externo" abre o documento
    E tento editar a seção "Dia 1 - Chegada" com o texto "Alteração não autorizada"
    Então devo receber um erro de autorização "Você não tem permissão para editar este documento"
