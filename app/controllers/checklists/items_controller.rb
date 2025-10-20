class Checklists::ItemsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_checklist
  before_action :set_checklist_item, only: [:update, :destroy]

  def create
    @item = @checklist.checklist_items.new(checklist_item_params)
    if @item&.save
      redirect_to @checklist #, notice: 'Item criado com sucesso'
    else
      head :unprocessable_content
      #render 'checklists/show', status: :unprocessable_content
    end
  end

  def update
    if @item&.update(checklist_item_params)
      redirect_to @checklist #, notice: 'Item atualizado com sucesso'
    else
      render 'checklists/show', status: :unprocessable_content
    end
  end

  def destroy
    @item&.destroy
    redirect_to @checklist #, notice: 'Item deletado com sucesso'
  end

  private

  def checklist_item_params
    params.require(:checklist_item).permit(:description, :check)
  end

  def set_checklist
    @checklist = current_user.checklists.find(params[:checklist_id])
  end

  def set_checklist_item
    @item = @checklist.checklist_items.find(params[:id])
  end
end
