require 'ostruct'

Quando('eu crio um evento chamado {string} com recorrência {string}') do |nome_evento, tipo_recorrencia|
  pending
end

Quando('eu tento criar um evento sem nome com recorrência {string}') do |tipo_recorrencia|
  pending
end

Então('devo ver o evento {string} aparecendo toda semana no calendário') do |nome_evento|
  pending
end

Então('devo ver o evento {string} aparecendo todos os dias no calendário') do |nome_evento|
  pending
end