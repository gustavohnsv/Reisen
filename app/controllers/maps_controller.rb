class MapsController < ApplicationController
  def search
  end

  def submit
    maps_search = MapsSearch.new(query: params[:query])
    if maps_search.valid?
      redirect_to maps_search.to_url, allow_other_host: true
    else
      flash.now[:alert] = 'Digite um termo para buscar.'
      render :search, status: :unprocessable_entity
    end
  end
end

