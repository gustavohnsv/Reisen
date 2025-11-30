require 'rails_helper'

RSpec.describe ScriptItemPhoto, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:script) { FactoryBot.create(:script, user: user) }
  let(:script_item) { FactoryBot.create(:script_item, script: script, user: user) }
  
  describe 'associations' do
    it 'pertence a um script_item' do
      association = ScriptItemPhoto.reflect_on_association(:script_item)
      expect(association.macro).to eq(:belongs_to)
    end
    
    it 'pertence a um usuário' do
      association = ScriptItemPhoto.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end
    
    it 'tem uma imagem anexada' do
      photo = FactoryBot.create(:script_item_photo, script_item: script_item, user: user)
      expect(photo.image).to be_attached
    end
  end
  
  describe 'validations' do
    it 'é válido com atributos válidos' do
      photo = FactoryBot.build(:script_item_photo, script_item: script_item, user: user)
      expect(photo).to be_valid
    end
    
    it 'não é válido sem imagem' do
      photo = ScriptItemPhoto.new(script_item: script_item, user: user)
      expect(photo).not_to be_valid
      expect(photo.errors[:image]).to include("can't be blank")
    end
    
    it 'não é válido com descrição muito longa' do
      photo = FactoryBot.build(:script_item_photo, 
                               script_item: script_item, 
                               user: user, 
                               description: 'a' * 501)
      expect(photo).not_to be_valid
      expect(photo.errors[:description]).to include("is too long (maximum is 500 characters)")
    end
    
    it 'é válido sem descrição' do
      photo = FactoryBot.build(:script_item_photo, 
                               script_item: script_item, 
                               user: user, 
                               description: nil)
      expect(photo).to be_valid
    end
  end
end