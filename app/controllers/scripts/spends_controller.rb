class Scripts::SpendsController < ApplicationController

  include ScriptPermissions
  include ScriptShowVariables

  before_action :set_script
  before_action :set_script_spend, only: [:destroy]

  before_action :set_script_permissions
  before_action :authorize_write_items_access!

  before_action :set_show_variables, only: [:create]

  def create
    @spend = @script&.script_spends&.new(script_spend_params)
    @spend.user_id = current_user.id
    if @spend.save
      redirect_to_script
    else
      head :unprocessable_content
    end
  end

  def destroy
    @spend = @script&.script_spends&.find(params[:id])
    if @spend.user_id == current_user.id
      @spend&.destroy
      redirect_to_script
    else
      redirect_to_script(alert: "Você não tem permissão para fazer isso")
    end
  end

  private

  def set_script
    if current_user
      @script = Script
                  .joins("LEFT JOIN script_participants ON script_participants.script_id = scripts.id")
                  .where("scripts.user_id = ? OR script_participants.user_id = ?", current_user.id, current_user.id)
                  .distinct
                  .find(params[:script_id])
    elsif params[:token].present?
      @script = Script.find_by(id: params[:script_id], shareable_token: params[:token])
    end
    if @script.nil?
      redirect_to root_path, alert: 'Você não tem permissão para fazer isso' and return
    end
  rescue ActiveRecord::RecordNotFound => _
    redirect_to root_path, alert: 'Você não tem permissão para fazer isso'
  end

  def set_script_spend
    @spend = @script&.script_spends&.find(params[:id])
  end

  def script_spend_params
    params.require(:script_spend).permit(
    :amount,
    :date,
    :category,
    :quantity,
    )
  end

  def redirect_to_script(options = {})
    if current_user
      redirect_to @script, options
    else
      redirect_to script_path(@script&.id, token: params[:token]), options
    end
  end
end
