require 'rails_helper'

RSpec.describe ScriptItem, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:script) { FactoryBot.create(:script, user: user) }
  let(:script_item) { FactoryBot.create(:script_item, script: script, user: user) }
  
  describe 'validations' do
    it 'é válido com atributos válidos' do
      expect(script_item).to be_valid
    end
    
    it 'não é válido sem title' do
      script_item.title = nil
      expect(script_item).not_to be_valid
    end
    
    it 'não é válido sem description' do
      script_item.description = nil
      expect(script_item).not_to be_valid
    end
    
    it 'não é válido sem location' do
      script_item.location = nil
      expect(script_item).not_to be_valid
    end
  end
  
  describe 'associations' do
    it 'pertence a um script' do
      association = ScriptItem.reflect_on_association(:script)
      expect(association.macro).to eq(:belongs_to)
    end
    
    it 'tem muitas reviews' do
      association = ScriptItem.reflect_on_association(:reviews)
      expect(association.macro).to eq(:has_many)
    end
    
    it 'tem muitas fotos' do
      association = ScriptItem.reflect_on_association(:script_item_photos)
      expect(association.macro).to eq(:has_many)
    end
    
    it 'deleta fotos quando deletado' do
      FactoryBot.create(:script_item_photo, script_item: script_item, user: user)
      expect { script_item.destroy }.to change { ScriptItemPhoto.count }.by(-1)
    end
  end
  
  describe '#total_photos' do
    it 'retorna 0 quando não há fotos' do
      expect(script_item.total_photos).to eq(0)
    end
    
    it 'retorna o número correto de fotos' do
      FactoryBot.create_list(:script_item_photo, 3, script_item: script_item, user: user)
      expect(script_item.total_photos).to eq(3)
    end
  end
  
  describe '#average_rating' do
    it 'retorna 0 quando não há avaliações' do
      expect(script_item.average_rating).to eq(0)
    end
  end
  
  describe '#total_reviews' do
    it 'retorna 0 quando não há avaliações' do
      expect(script_item.total_reviews).to eq(0)
    end
  end
end