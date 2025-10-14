require 'rails_helper'

RSpec.describe "layouts/_header", type: :view do
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
end
