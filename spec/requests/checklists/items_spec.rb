require 'rails_helper'

RSpec.describe "Checklists::Items", type: :request do

  let!(:user) {FactoryBot.create(:user)}
  let!(:checklist) {FactoryBot.create(:checklist, user: user)}
  let!(:item) {FactoryBot.create(:checklist_item, checklist: checklist)}

  describe 'PATCH /checklists/:checklist_id/checklist_items/:id' do
    context 'usuario esta logado' do
      before do
        sign_in(user)
      end
      it 'atualiza apenas o titulo do item com sucesso' do
        patch checklist_checklist_item_path(checklist.id, item.id), params: {
          checklist_item: {description: 'Item atualizado'}
        }
        expect(item.reload.description).to eq('Item atualizado')
        expect(response).to redirect_to(checklist_path(checklist.id))
      end
      it 'atualiza apenas o estado do item com sucesso' do
        patch checklist_checklist_item_path(checklist.id, item.id), params: {
          checklist_item: {check: true}
        }
        expect(item.reload.check).to eq(true)
        expect(response).to redirect_to(checklist_path(checklist.id))
      end
      it 'nao atualiza o titulo da checklist' do
        patch checklist_checklist_item_path(checklist.id, item.id), params: {
          checklist_item: {description: ''}
        }
        expect(response).to render_template('checklists/show')
      end
    end
  end
  describe 'POST  /checklists/:checklist_id/checklist_items' do
    context 'usuario esta logado' do
      before do
        sign_in(user)
      end
      it 'o item da checklist e criado com sucesso' do
        expect {
          post checklist_checklist_items_path(checklist.id), params: {
            checklist_item: {description: 'Novo item'}
          }
        }.to change(ChecklistItem, :count).by(1)
        expect(response).to redirect_to(checklist_path(checklist.id))
      end
      it 'o item da checklist nao e criado com sucesso' do
        expect {
          post checklist_checklist_items_path(checklist.id), params: {
            checklist_item: {description: ''}
          }
        }.to change(ChecklistItem, :count).by(0)
        expect(response).to render_template('checklists/show')
      end
    end
  end
  describe 'DELETE /checklists/:checklist_id/checklist_items/:id' do
    context 'usuario esta logado' do
      before do
        sign_in(user)
      end
      it 'deleta o item com sucesso' do
        expect {
          delete checklist_checklist_item_path(checklist.id, item.id)
        }.to change(ChecklistItem, :count).by(-1)
        expect(response).to redirect_to(checklist_path(checklist.id))
      end
    end
  end
end
