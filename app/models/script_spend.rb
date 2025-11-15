class ScriptSpend < ApplicationRecord
  belongs_to :user
  belongs_to :script

  enum :category, {
    transporte: 1,
    acomodacao: 2,
    alimentacao: 3,
    atividades: 4,
    compras: 5,
    outros: 6
  }

  validates :amount, presence: true
  validates :date, presence: true
  validates :category, presence: true
  validates :quantity, presence: true
end
