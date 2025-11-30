class ScriptItems::PhotosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_script_item
  before_action :set_photo, only: [:destroy]
  before_action :authorize_photo_owner!, only: [:destroy]
  
  def create
    @photo = @script_item.script_item_photos.new(photo_params)
    @photo.user = current_user
    
    if @photo.save
      redirect_to script_path(@script_item.script), notice: 'Foto adicionada com sucesso'
    else
      redirect_to script_path(@script_item.script), alert: @photo.errors.full_messages.join(', ')
    end
  end
  
  def destroy
    @photo.destroy
    redirect_to script_path(@script_item.script), notice: 'Foto deletada com sucesso'
  end
  
  private
  
  def set_script_item
    @script_item = ScriptItem.find(params[:script_item_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'Item não encontrado'
  end
  
  def set_photo
    @photo = @script_item.script_item_photos.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to script_path(@script_item.script), alert: 'Foto não encontrada'
  end
  
  def authorize_photo_owner!
    unless @photo.user == current_user || @script_item.script.user == current_user
      redirect_to script_path(@script_item.script), alert: 'Você não tem permissão para fazer isso'
    end
  end
  
  def photo_params
    params.require(:script_item_photo).permit(:image, :description)
  end
end