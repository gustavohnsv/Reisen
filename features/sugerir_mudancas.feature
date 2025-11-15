# language: pt
# encoding: utf-8

Funcionalidade: Sugerir mudanças
  Para adicionar comentários em seções específicas do documento compartilhado

  #Contexto:
  #  Dado que estou autenticado como membro do grupo "Viagem para Europa"
  #  E estou visualizando o documento "Roteiro de Paris"

  #Cenário: Adicionar comentário com sucesso
  #  E existe a seção "Dia 1 - Chegada em Paris"
  #  Quando eu adiciono o comentário "Podemos visitar o Louvre nesse dia?"
  #  Então devo ver o comentário "Podemos visitar o Louvre nesse dia?" associado à seção "Dia 1 - Chegada em Paris"

  #Cenário: Visualizar comentários existentes
  #  Dado que existe um comentário "Adicionar visita ao museu d'Orsay" na seção "Dia 2 - Passeios"
  #  Quando eu visualizo o documento "Roteiro de Paris"
  #  Então devo ver o comentário "Adicionar visita ao museu d'Orsay" na seção "Dia 2 - Passeios"

  #Cenário: Falha ao adicionar comentário vazio
  #  E existe a seção "Dia 3 - Retorno"
  #  Quando eu tento adicionar um comentário vazio
  #  Então devo ver a mensagem de erro "O comentário não pode estar em branco"
