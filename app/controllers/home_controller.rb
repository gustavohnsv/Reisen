class HomeController < ApplicationController
  def index
   # carregar avisos visíveis para exibição na home
    @notices = Notice.visible.order(created_at: :desc)
  end
end
