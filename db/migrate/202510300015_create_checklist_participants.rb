class CreateChecklistParticipants < ActiveRecord::Migration[7.1]
  def change
    # Criar a tabela sem adicionar constraints de foreign key imediatamente
    create_table :checklist_participants do |t|
      t.references :user, null: false
      t.references :checklist, null: false
      t.string :role, null: false, default: 'collaborator'

      t.timestamps
    end

    add_index :checklist_participants, [:checklist_id, :user_id], unique: true, name: 'index_checklist_participants_on_checklist_and_user'

    # Adiciona as foreign keys somente se as tabelas de destino existirem
    if ActiveRecord::Base.connection.data_source_exists?(:users)
      add_foreign_key :checklist_participants, :users
    end

    if ActiveRecord::Base.connection.data_source_exists?(:checklists)
      add_foreign_key :checklist_participants, :checklists
    end
  end
end