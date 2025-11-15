# language: pt
# encoding: utf-8

Funcionalidade: Visualizar notícias de turismo
Como viajante
Quero ver notícias locais sobre viagens
Para me manter atualizado

Cenário: Buscar notícias de turismo para Lisboa
Quando eu busco notícias de turismo para "Lisboa"
Então eu devo ver uma lista com notícias
E cada notícia deve ter um título
E cada notícia deve ter uma data
E cada notícia deve ter um link

