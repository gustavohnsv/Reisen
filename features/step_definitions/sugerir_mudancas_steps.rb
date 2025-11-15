Dado('que estou autenticado como membro do grupo {string}') do |nome_grupo|
  pending
end

Dado('estou visualizando o documento {string}') do |titulo_documento|
  pending
end

Dado('existe a seção {string}') do |nome_secao|
  pending
end

Quando('eu adiciono o comentário {string}') do |texto_comentario|
  pending
end

Então('devo ver o comentário {string} associado à seção {string}') do |texto_comentario, nome_secao|
  pending
end

Dado('que existe um comentário {string} na seção {string}') do |comentario, nome_secao|
  pending
end

Quando('eu visualizo o documento {string}') do |_titulo_documento|
  pending
end

Então('devo ver o comentário {string} na seção {string}') do |comentario, nome_secao|
  pending
end

Quando('eu tento adicionar um comentário vazio') do
  pending
end

Então('devo ver a mensagem de erro {string}') do |mensagem_erro|
  pending
end
