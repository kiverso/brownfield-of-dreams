require 'rails_helper'

describe 'A registered user' do
  it 'can add videos to their bookmarks' do
    tutorial = create(:tutorial, title: "How to Tie Your Shoes")
    video = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    expect {
      click_on 'Bookmark'
    }.to change { UserVideo.count }.by(1)

    expect(page).to have_content("Bookmark added to your dashboard")
  end

  it "can't add the same bookmark more than once" do
    tutorial= create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    click_on 'Bookmark'
    expect(page).to have_content("Bookmark added to your dashboard")
    click_on 'Bookmark'
    expect(page).to have_content("Already in your bookmarks")
  end

  it 'can show a user all their bookmarked videos' do
    tutorial = create(:tutorial, title: "How to Tie Your Shoes")
    tutorial2 = create(:tutorial, title: "How to do Another Thing")
    video = create(:video, title: "The Bunny Ears Technique", position: 2, tutorial: tutorial)
    video2 = create(:video, title: "Another Technique", position: 1, tutorial: tutorial)
    video3 = create(:video, title: "Basic other thing", tutorial: tutorial2)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    expect {
      click_on 'Bookmark'
    }.to change { UserVideo.count }.by(1)

    click_link(video.title)

    expect {
      click_on 'Bookmark'
    }.to change { UserVideo.count }.by(1)

    visit tutorial_path(tutorial2)
    expect {
      click_on 'Bookmark'
    }.to change { UserVideo.count }.by(1)

    visit dashboard_path
    within('.bookmarks') do
      within("#tutorial-#{tutorial.id}") do
        expect(video2.title).to appear_before(video1.title)
      end
      within("#tutorial-#{tutorial2.id}") do
        expect(page).to have_content(tutorial2.title)
        expect(page).to have_content(video3.title)
      end
    end
  end
end
