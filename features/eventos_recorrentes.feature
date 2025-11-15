# language: pt
# encoding: utf-8

Funcionalidade: Eventos recorrentes
  Para poder marcar eventos recorrentes no calendário

  #Contexto:
  #  Dado que estou autenticado como planejador de viagem
  #  E possuo um calendário de viagem

  #Cenário: Criar um evento recorrente semanal com sucesso
  #  Quando eu crio um evento chamado "Reunião de planejamento" com recorrência "semanal"
  #  Então devo ver o evento "Reunião de planejamento" aparecendo toda semana no calendário

  #Cenário: Criar um evento recorrente diário
  #  Quando eu crio um evento chamado "Checar reservas" com recorrência "diária"
  #  Então devo ver o evento "Checar reservas" aparecendo todos os dias no calendário

  #Cenário: Falha ao criar evento sem nome
  #  Quando eu tento criar um evento sem nome com recorrência "mensal"
  #  Então devo ver a mensagem de erro no calendário "O nome do evento não pode estar em branco"
