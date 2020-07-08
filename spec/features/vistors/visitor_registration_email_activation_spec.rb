require 'rails_helper'

RSpec.describe 'As a guest' do
  it 'the email activation link is sent when i register as a new user' do
    visit '/'

    click_on("Register")

    expect(current_path).to eq('/register')

    fill_in 'user_email', with: 'garfield@example.com'
    fill_in 'user_first_name', with: 'Garfield'
    fill_in 'user_last_name', with: 'The Cat'
    fill_in 'user_password', with: 'lasagna'
    fill_in 'user_password_confirmation', with: 'lasagna'
    click_on('Create Account')

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("Logged in as Garfield The Cat")
    expect(page).to have_content("This account has not yet been activated. Please check your email.")

    user = User.last

    expect(user.email_activation).to be_nil

    expect(page).to have_content("Status: Inactive")

    user.update_attribute(:email_activation,  "Confirmed")

    user.reload

    visit dashboard_path

    expect(page).to have_content("Status: Active")
  end
end
