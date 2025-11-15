class MocksController < ApplicationController
  def latam
    render plain: "Página da companhia área Latam"
  end
  def gol
    render plain: "Página da companhia área Gol"
  end
  def azul
    render plain: "Página da companhia área Azul"
  end
  def erro
    render plain: "Erro: Site da companhia área fora de ar!", status: 500
  end
end
