require 'rails_helper'

RSpec.describe MapsSearch, type: :model do
  it 'valida presença de query' do
    ms = described_class.new(query: '')
    expect(ms.valid?).to be_falsey
  end

  it 'monta URL com espaços corretamente' do
    ms = described_class.new(query: 'Padaria perto de mim')
    expect(ms.to_url).to eq('https://www.google.com/maps/search/?api=1&query=Padaria+perto+de+mim')
  end

  it 'monta URL com acentos e especiais corretamente' do
    ms = described_class.new(query: 'Açaí & Café')
    expect(ms.to_url).to eq('https://www.google.com/maps/search/?api=1&query=A%C3%A7a%C3%AD+%26+Caf%C3%A9')
  end

  it 'lança erro quando query está vazia para to_url' do
    ms = described_class.new(query: '   ')
    expect { ms.to_url }.to raise_error(ArgumentError, 'query is required')
  end
end

