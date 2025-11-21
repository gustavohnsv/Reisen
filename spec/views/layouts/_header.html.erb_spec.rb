require 'rails_helper'

RSpec.describe "layouts/_header", type: :view do
  context 'quando não autenticado' do
    before do
      # Avoid calling into Warden/Devise middleware in view specs by stubbing helpers
      allow(view).to receive(:user_signed_in?).and_return(false)
      allow(view).to receive(:current_user).and_return(nil)
      render
    end

    it 'exibe link para a página principal' do
      expect(rendered).to have_link("Reisen", href: root_path)
    end

    it 'exibe link para a página de Login' do
      # Quando não autenticado, o link de Perfil aponta para a página de login
      expect(rendered).to have_link("Login", href: new_user_session_path)
    end

    it 'exibe link para o roteiro rápido' do
      expect(rendered).to have_link("Roteiro", href: roteiro_path)
    end

    it 'exibe link para a página de Notícias' do
      # Pesquisa por notícias de Turismo em pt-BR do Google News
      expect(rendered).to have_link("Notícias", href: news_path)
    end
  end

  context 'quando autenticado' do
    let(:avatar_double) { double('Avatar', attached?: false) }
    let(:user_double) do
      instance_double(User,
                      name: 'Usuário Teste',
                      email: 'usuario@example.com',
                      avatar: avatar_double)
    end

    before do
      allow(view).to receive(:user_signed_in?).and_return(true)
      allow(view).to receive(:current_user).and_return(user_double)
      render
    end

    it 'não exibe o link para o roteiro rápido' do
      expect(rendered).not_to have_link("Roteiro", href: roteiro_path)
    end
  end
end
