require 'rails_helper'

RSpec.describe 'as an admin' do
  before(:each) do
    @admin = User.create!(email: 'admin@example.com', password: 'asdf123', first_name: 'admin1', role: 1)
  end
  it 'can import a new youtube playlist' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

    visit new_admin_tutorial_path

    click_link('Import YouTube Playlist')

    expect(current_path).to eq(admin_playlist_new_path)
    fill_in'tutorial[playlist_id]', with: 'PLjIwAcWBM5nRdYCmZLB0pCeA3ioHetoFp'
    click_on('Submit')

    expect(page).to have_content('Successfully created tutorial.')

    expect(current_path).to eq(admin_dashboard_path)

    click_link('View it here')

    tutorial = Tutorial.last

    expect(current_path).to eq(tutorial_path(tutorial))

    expect(page).to have_css('.show-link', count: 56)

    videos = tutorial.videos

    video = videos[0]

    video1 = videos[-1]

    within "#video-1" do
      expect(page).to have_link(video.title)
    end

    within "#video-55" do
      expect(page).to have_link(video1.title)
    end
  end
end
