class ScriptsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_script, only: [:show, :edit, :update]
  before_action :check_ownership, only: [:edit, :update]
  def show
    @airlines = airlines
    @item = @script&.script_items&.build
  end

  def new
    @script = Script.new
  end

  def create
    @script = current_user.scripts.new(script_params)
    if @script&.save
      redirect_to @script, notice: "Roteiro criado com sucesso"
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
    # Já tem os dados do roteiro devido ao 'before_action :set_script'
  end

  def update
    if @script&.update(script_params)
      redirect_to @script, notice: "Roteiro editado com sucesso"
    else
      head :unprocessable_content
      #render :edit, status: :unprocessable_content
    end
  end

  def destroy
    if (@script = current_user.scripts.find(params[:id]))
      @script&.destroy
      redirect_to root_path, notice: "Roteiro deletado com sucesso"
    end
  rescue ActiveRecord::RecordNotFound => _
    redirect_to root_path, alert: 'Você não tem permissão para fazer isso'
  end

  protected

  def set_script
    if current_user
      @script = Script
                  .joins("LEFT JOIN participants ON participants.script_id = scripts.id")
                  .where("scripts.user_id = ? OR participants.user_id = ?", current_user.id, current_user.id)
                  .distinct
                  .find(params[:id])
    elsif params[:token].present?
      @script = Script.find_by(id: params[:id], shareable_token: params[:token])
    end
    if @script.nil?
      redirect_to root_path, alert: 'Você não tem permissão para fazer isso' and return
    end
    rescue ActiveRecord::RecordNotFound => _
      redirect_to root_path, alert: 'Você não tem permissão para fazer isso'
  end

  def script_params
    params.require(:script).permit(
      :title,
      script_items_attributes: [
        :id,
        :title,
        :description,
        :location,
        :date_time_start,
        :estimated_cost,
        :_destroy]
    )
  end

  def check_ownership
    unless @script&.user == current_user
      redirect_to root_path, alert: 'Você não tem permissão para fazer isso'
    end
  end

  private
  def airlines
    {
      "Latam" => "https://www.latamairlines.com/br/pt",
      "Gol" => "https://www.voegol.com.br/",
      "Azul" => "https://www.voeazul.com.br/home/br/pt/home"
    }
  end
end
