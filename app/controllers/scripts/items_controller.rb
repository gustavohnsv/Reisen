class Scripts::ItemsController < ApplicationController

  include ScriptPermissions
  include ScriptShowVariables

  before_action :set_script
  before_action :set_script_item, only: [:update, :destroy]

  before_action :set_script_permissions
  before_action :authorize_write_items_access!

  def create
    @item = @script&.script_items&.new(script_item_params)
    @item.user_id = current_user.id
    if @item&.save
      redirect_to_script
    else
      head :unprocessable_content
    end
  end

  def update
    if @item&.update(script_item_params)
      redirect_to_script
    else
      set_show_variables
      render 'scripts/show', status: :unprocessable_content
    end
  end

  def destroy
    @item&.destroy
    redirect_to_script
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

  def set_script_item
    @item = @script&.script_items&.find(params[:id])
  end

  def script_item_params
    params.require(:script_item).permit(
      :title,
      :description,
      :location,
      :date_time_start,
      :estimated_cost,
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
