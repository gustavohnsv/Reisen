class ScriptsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :news]
  before_action :set_script, only: [:show, :edit, :update, :destroy, :news]
  before_action :check_ownership, only: [:edit, :update, :destroy]
  def show
    @airlines = airlines
  end

  def new
    @script = Script.new
  end

  def create
    @script = current_user.scripts.new(script_params)
    if @script.save
      redirect_to @script, notice: "Roteiro criado com sucesso"
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
  end

  def update
    if @script.update(script_params)
      redirect_to @script, notice: "Roteiro editado com sucesso"
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @script.destroy
    redirect_to root_path, notice: "Roteiro deletado com sucesso"
  end

  def news
    render plain: 'Página dedicadas a notícias relacionadas ao destino da viagem :)'
  end

  private

  def set_script
    if current_user.nil?
      redirect_to root_path, alert: "Acesso negado" and return
    end
    @script = Script
                .joins("LEFT JOIN participants ON participants.script_id = scripts.id")
                .where("scripts.user_id = ? OR participants.user_id = ?", current_user.id, current_user.id)
                .distinct
                .find(params[:id])
    rescue ActiveRecord::RecordNotFound => _
      redirect_to root_path
  end

  def script_params
    params.require(:script).permit(:title)
  end

  def check_ownership
    unless @script.user == current_user
      redirect_to root_path, alert: 'Você não tem permissão para fazer isso'
    end
  end

  def airlines
    {
      "Latam" => "https://www.latamairlines.com/br/pt",
      "Gol" => "https://www.voegol.com.br/",
      "Azul" => "https://www.voeazul.com.br/home/br/pt/home"
    }
  end
end
