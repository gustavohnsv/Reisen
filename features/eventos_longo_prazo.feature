# language: pt
# encoding: utf-8

Funcionalidade: Eventos de longo prazo
  Para poder marcar eventos que duram múltiplos dias no calendário

  #Contexto:
  #  Dado que estou autenticado como planejador de viagem
  #  E possuo um calendário de viagem

  #Cenário: Criar evento de longo prazo com sucesso
  #  Quando eu crio um evento chamado "Cruzeiro pelo Mediterrâneo" com data de início "2025-07-10" e data de término "2025-07-20"
  #  Então devo ver o evento "Cruzeiro pelo Mediterrâneo" durando de "2025-07-10" até "2025-07-20" no calendário

  #Cenário: Falha ao criar evento com data final anterior à inicial
  #  Quando eu tento criar um evento chamado "Excursão Alpes" com data de início "2025-08-15" e data de término "2025-08-10"
  #  Então devo ver a mensagem de erro no calendário "A data de término não pode ser anterior à data de início"

  #Cenário: Falha ao criar evento sem nome
  #  Quando eu tento criar um evento sem nome com data de início "2025-09-01" e data de término "2025-09-05"
  #  Então devo ver a mensagem de erro no calendário "O nome do evento não pode estar em branco"
