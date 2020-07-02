require 'rails_helper'
RSpec.describe "As a logged in user, when i click on the github section" do
  before(:each) do
    @happy = User.create!(email: 'happymadison@example.com', first_name: 'Happy', last_name: 'Gilmore', password: '12345', token: ENV["github_api_token_c"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@happy)
  end
  it 'can view 5 repos from their github account' do
    visit '/dashboard'

    expect(page).to have_css('#repo', count: 5)
    expect(page).to have_content('Github')
  end
  # it 'can click on specific repos and be taken to that github path' do
  #   repo = Repo.new("New Repo", 'http://www.github.com/cgaddis36/battleship')
  #
  # end
end
