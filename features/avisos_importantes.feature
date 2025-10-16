# language: pt
# encoding: utf-8

Funcionalidade: Avisos importantes
Como líder do grupo
Para que meu grupo não se esqueça de certas informações importantes
Quero enviar lembretes visíveis para a home deles

Contexto: existe um aviso importante visível
Dado que existe um aviso com o título "Reunião de grupo" e o corpo "Reunião amanhã às 10h" marcado como visível

Cenário: Visualizar avisos importantes na página inicial
Quando acesso a página inicial
Então devo ver o texto "Avisos importantes"
E devo ver um aviso com o texto "Reunião de grupo"
E devo ver o texto "Reunião amanhã às 10h"
