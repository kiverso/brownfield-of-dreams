require 'rails_helper'

RSpec.describe 'as a logged in user' do
  before(:each) do
    @user = User.create!(email: 'user@example.com', first_name: 'user1', last_name: 'Jenkins', password: '12345')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end
  it 'I can connect with my github account' do

    visit dashboard_path

    # expect(page).to have_link("Connect to Github")
  end
end

# As a user
# When I visit /dashboard
# Then I should see a link that is styled like a button that says "Connect to Github"
# And when I click on "Connect to Github"
# Then I should go through the OAuth process
# And I should be redirected to /dashboard
# And I should see all of the content from the previous Github stories (repos, followers, and following)
