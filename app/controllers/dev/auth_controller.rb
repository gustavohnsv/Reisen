# frozen_string_literal: true

module Dev
  class AuthController < ApplicationController
    before_action :ensure_dev

    # GET /dev/login/:id
    def login_as
      user = User.find_by(id: params[:id])
      if user
        sign_in(user)
        redirect_to profile_path(user), notice: "Logado como #{user.name} (dev)"
      else
        redirect_to root_path, alert: 'Usuário não encontrado'
      end
    end

    private

    def ensure_dev
      head :not_found unless Rails.env.development?
    end
  end
end