require 'rails_helper'

RSpec.describe 'as an admin' do
  before(:each) do
    @admin = User.create!(email: 'admin@example.com', password: 'asdf123', first_name: 'admin1', role: 1)
  end
  it 'can import a new youtube playlist' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

    visit new_admin_tutorial_path

    click_link('Import YouTube Playlist')

    fill_in'tutorial[playlist_id]', with: 'RDhV0te5pf0NE'
    click_on('Submit')

    expect(current_path).to eq(admin_playlist_path)
    expect(page).to have_content('Successfully created tutorial. View it here.')

    click_link('View it here')

    tutorial = Tutorial.last

    expect(current_path).to eq(tutorial_path(tutorial))

    videos = tutorial.videos
  end
end
# As an admin
# When I visit '/admin/tutorials/new'
# Then I should see a link for 'Import YouTube Playlist'
# When I click 'Import YouTube Playlist'
# Then I should see a form
#
# And when I fill in 'Playlist ID' with a valid ID
# Then I should be on '/admin/dashboard'
# And I should see a flash message that says 'Successfully created tutorial. View it here.'
# And 'View it here' should be a link to '/tutorials/:id'
# And when I click on 'View it here'
# Then I should be on '/tutorials/:id'
# And I should see all videos from the YouTube playlist
# And the order should be the same as it was on YouTube
