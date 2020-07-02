require 'rails_helper'
RSpec.describe "As a logged in user, when i click on the github section" do
  before(:each) do
    @happy = User.create!(email: 'happymadison@example.com', first_name: 'Happy', last_name: 'Gilmore', password: '12345', token: ENV["github_api_token_k"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@happy)
  end
  it 'can view 5 repos from their github account' do
    visit '/dashboard'

    expect(page).to have_css('#repo', count: 5)
    expect(page).to have_content('Github')
    expect(page).to have_link('monster_shop_2003')
    expect(page).to have_link('futbol')
    expect(page).to have_link('adopt_dont_shop_2003')
    expect(page).to have_link('b2-mid-mod')
    expect(page).to have_link('backend_module_0_capstone')
  end
end
