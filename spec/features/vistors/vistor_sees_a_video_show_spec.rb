require 'rails_helper'

describe 'visitor sees a video show' do
  it 'vistor clicks on a tutorial title from the home page' do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    visit '/'

    click_on tutorial.title

    expect(current_path).to eq(tutorial_path(tutorial))
    expect(page).to have_content(video.title)
    expect(page).to have_content(tutorial.title)
  end

  it 'visitor tries to view a video for classroom content' do
    tutorial1 = create(:classroom_tutorial)
    tutorial2 = create(:tutorial)

    video1 = create(:video, tutorial_id: tutorial1.id)
    video2 = create(:video, tutorial_id: tutorial2.id)

    visit '/'

    expect(page).to_not have_link(tutorial1.title)
    visit tutorial_path(tutorial1)

    expect(current_path).to eq(tutorial_path(tutorial1))
    expect(page).to_not have_content(video1.title)
    expect(page).to_not have_content(tutorial1.title)
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
