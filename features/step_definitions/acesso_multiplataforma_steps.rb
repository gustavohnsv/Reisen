Given('there is a registered traveler with a saved plan') do
  @traveler = FactoryBot.create(:user, email: 'traveler@example.com', password: 'password')
  @plan = FactoryBot.create(:script, title: 'Plano de Viagem', user: @traveler)
  expect(@traveler).to be_present
  expect(@plan).to be_present
end

When('the traveler signs in from another device') do
  # Simula o fluxo de login via formulário (como em outro dispositivo)
  visit new_user_session_path
  fill_in 'Email', with: @traveler.email
  fill_in 'Password', with: 'password'
  click_button 'Log in'
end

Then('the traveler should see their saved plan') do
  expect(page).to have_content(@plan.title)
end
