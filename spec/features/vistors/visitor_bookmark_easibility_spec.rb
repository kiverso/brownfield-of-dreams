require 'rails_helper'

RSpec.describe 'As a visitor' do
  it 'when I attempt to bookmark a video, a flash message is displayed to login' do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    visit tutorial_path(tutorial)

    expect(page).to have_content("User must Login to bookmark video")

    click_link("Login")

    expect(current_path).to eq(login_path)
  end
end
