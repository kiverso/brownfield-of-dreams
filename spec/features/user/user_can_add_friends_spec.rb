require 'rails_helper'

RSpec.describe 'As a user that is connected to github in the system' do
  before(:each) do
    @josh = User.create!(email: 'josh@example.com', first_name: 'Josh', last_name: 'Gilmore', password: '12345', url: 'https://github.com/cgaddis36', token: ENV["github_api_token_c"])
    @dione = User.create!(email: 'dione@example.com', first_name: 'Dione', last_name: 'Lopez', password: '123885', url: 'https://github.com/kiverso', token: ENV["github_api_token_k"])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@josh)
  end
  it 'I can add other users in the system that are also connected to Github' do
    visit dashboard_path

    within "#following-kiverso" do
      expect(page).to have_link("Add kiverso as Friend")
      click_link("Add kiverso as Friend")
    end

    expect(page).to have_content("Successfully added Dione Lopez as a friend")

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_css('#friend', count: 1)
  end
end

# Details: We want to create friendships between users with accounts in our database.
# Long term we want to make video recommendations based on what friends are bookmarking.
# This card should not include the recommendation logic. That's coming in a different user story.
#
# Background: A user (Josh) exists in the system with a Github token.
# The user has two followers on Github. One follower (Dione) also has an account within our
# database. The other follower (Mike) does not have an account in our system. If a follower
# or following has an account in our system we want to include a link next to their name to
 # allow us to add as a friend.
#
# In this case Dione would have an Add as Friend link next to her name. Mike would not
# have the link next to his name.
#
# Tips: No need to work on edge cases during your spike. You'll want to research self
# referential has_many through. Here's a good starting point to understand
# the concept: http://blog.hasmanythrough.com/2007/10/30/self-referential-has-many-through.
# You'll probably need to do more googling but that's part of the fun ;)
#
#  Links show up next to followers that have accounts in our system.
#  Links show up next to followings that have accounts in our database.
#  Links do not show up next to followers or followings if they are not in our database.
#  There's a section on the dashboard that shows all of the users that I have friended
#  Edge Case: Make sure this fails gracefully. If you open up a POST route to create a friendship,
# be sure to catch the scenario where someone sends an invalid user id. Send a flash message alerting
# them of the error.
