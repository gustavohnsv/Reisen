# language: pt
Funcionalidade: SEO e Metadados
  Como um visitante do site
  Eu quero ver metadados corretos nas páginas
  Para que o site seja bem indexado pelos motores de busca e compartilhado corretamente

  Cenário: Verificar metadados na página inicial
    Dado que eu estou na página inicial
    Então a página deve ter o título "Planejamento de Viagens | Reisen"
    E a página deve ter a meta tag "description" preenchida
    E a página deve ter a meta tag "keywords" preenchida
    E a página deve ter as tags Open Graph configuradas

  Cenário: Verificar metadados em um roteiro público
    Dado que existe um roteiro público com título "Viagem para Paris"
    Quando eu acesso a página desse roteiro
    Então a página deve ter o título "Viagem para Paris | Reisen"
    E a página deve ter a meta tag "description" contendo "Viagem para Paris"
