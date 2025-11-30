class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :username, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :username, :avatar, :remove_avatar])
  end

  before_action :set_default_meta_tags

  private

  def set_default_meta_tags
    set_meta_tags site: 'Reisen',
                  title: 'Planejamento de Viagens',
                  reverse: true,
                  description: 'Um portal completo para planejamento de viagens colaborativo.',
                  keywords: 'viagem, planejamento, roteiro, amigos, familia',
                  og: {
                    title: :title,
                    description: :description,
                    type: 'website',
                    url: request.original_url,
                    image: view_context.image_url('reisen-logo.png')
                  }
  end
end