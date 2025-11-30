# features/step_definitions/accessibility_steps.rb

Então('a página não deve ter violações de acessibilidade \(WCAG 2.1 AA\)') do
  expect(page).to be_axe_clean
end

