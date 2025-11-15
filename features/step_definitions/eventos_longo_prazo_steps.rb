require 'ostruct'
require 'date'

Quando('eu crio um evento chamado {string} com data de início {string} e data de término {string}') do |nome_evento, data_inicio, data_fim|
  pending
end

Quando('eu tento criar um evento chamado {string} com data de início {string} e data de término {string}') do |nome_evento, data_inicio, data_fim|
  pending
end

Quando('eu tento criar um evento sem nome com data de início {string} e data de término {string}') do |data_inicio, data_fim|
  pending
end

Então('devo ver o evento {string} durando de {string} até {string} no calendário') do |nome_evento, data_inicio, data_fim|
  pending
end
