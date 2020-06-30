require 'rails_helper'
RSpec.describe "As a logged in user, when i click on the github section" do
  before(:each) do
    @happy = User.create!(email: 'happymadison@example.com', first_name: 'Happy', last_name: 'Gilmore', password: '12345', token: ENV["github_api_token-k"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@happy)
  end
  it 'can view 5 repos from their github account' do
    visit '/dashboard'
    expect(page).to have_content('Github')
    expect(page).to have_link('Neos')
    expect(page).to have_link('Brownfield of Dreams')
    expect(page).to have_link('Here Be Dragons')
    expect(page).to have_link('Sweater Weather')
    expect(page).to have_link('Something Else')
  end
end
#As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see a list of 5 repositories with the name of each Repo linking to the repo on Github