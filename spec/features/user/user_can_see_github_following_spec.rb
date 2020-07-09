require 'rails_helper'

RSpec.describe 'As a logged in user, connected to github' do
  before(:each) do
    @happy = User.create!(email: 'happymadison@example.com', first_name: 'Happy', last_name: 'Gilmore', password: '12345', token: ENV["github_api_token_c"])
  end
  it 'I see the following associated to that users github account on the dashboard', :vcr do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@happy)

    visit dashboard_path

    expect(page).to have_content('iandouglas')
    expect(page).to have_content('KellyIB')
    expect(page).to have_content('alerrian')
    expect(page).to have_content('meghanstovall')
    expect(page).to have_content('kiverso')
    expect(page).to have_content('palworth')
  end
end
