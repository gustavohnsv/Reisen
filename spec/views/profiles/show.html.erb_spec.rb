require 'rails_helper'

RSpec.describe "profiles/show.html.erb", type: :view do
  # Cria um usuário fake
  let!(:user) do
    User.create!(
      name: 'John Smith',
      email: 'johnsmith@example.com',
      password: 'password',
      password_confirmation: 'password',
      confirmed_at: Time.current
    )
  end

  # Cria um roteiro e uma checklist para o usuário
  let!(:script) {user.scripts.create!(title: 'Roteiro')}
  let!(:checklist) {user.checklists.create!(title: 'Checklist')}

  # Diz que:
  # 1°: antes de cada passo, garanta que a variável usuário é o nosso usuário fake
  # 2°: garante que o usuário fake esteja logado no sistema
  # 3°: renderize a página
  before(:each) do
    assign(:user, user)
    assign(:scripts, [script])
    assign(:checklists, [checklist])
    sign_in(user)
    render
  end

  it 'deve conter o nome do usuário' do
    expect(rendered).to have_content(user.name)
  end
  it 'deve conter um botão para sair' do
    expect(rendered).to have_button('Sair (Logout)')
  end
  it 'deve conter um botão para criar um novo roteiro' do
    expect(rendered).to have_button('Novo roteiro')
  end
  it 'deve conter um botão para criar uma nova checklist' do
    expect(rendered).to have_button('Nova checklist')
  end
  it 'caso eu tenha um roteiro, devo ver um link do roteiro' do
    expect(rendered).to have_link(script.title)
  end
  it 'caso eu tenha uma checklist, devo ver um link da checklist' do
    expect(rendered).to have_link(checklist.title)
  end
end
