require 'rails_helper'

RSpec.describe 'As a user that is connected to github in the system' do
  before(:each) do
    @josh = User.create!(email: 'josh@example.com', first_name: 'Josh', last_name: 'Gilmore', password: '12345', url: 'https://github.com/cgaddis36', token: ENV["github_api_token_c"])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@josh)
  end
  it 'I can invite other github users' do
    visit dashboard_path

    click_link('Send an Invite')

    expect(current_path).to eq('/invite')

    fill_in :invitee_github, with: 'kiverso'
    expect{
    click_button 'Send Invite'}.to change { ActionMailer::Base.deliveries.count }.by(1)

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Successfully sent invite!')
  end
end

# As a registered user
# When I visit /dashboard
# And I click "Send an Invite"
# Then I should be on /invite

# And when I fill in "Github Handle" with <A VALID GITHUB HANDLE>
# And I click on "Send Invite"
# Then I should be on /dashboard
# And I should see a message that says "Successfully sent invite!" (if the user has an email address associated with their github account)
# Or I should see a message that says "The Github user you selected doesn't have an email address associated with their account."
# The email should read as follows

# Hello <INVITEE_NAME_AS_IT_APPEARS_ON_GITHUB>,

# <INVITER_NAME_AS_IT_APPEARS_ON_GITHUB> has invited you to join <YOUR_APP_NAME>. You can create an account <here (should be a link to /signup)>.



