require 'rails_helper'

feature "An admin can delete a tutorial" do
  scenario "and it should no longer exist" do
    admin = create(:admin)
    tutorials = create_list(:tutorial, 2)
    tutorial = tutorials[0]
    video = Video.create!(title: 'New Video', description: 'This is the newest video on Youtube.', tutorial_id: tutorial.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/dashboard"

    expect(page).to have_css('.admin-tutorial-card', count: 2)

    within(first('.admin-tutorial-card')) do
      click_button 'Delete'
    end

    expect(tutorial.videos).to be_empty

    expect(page).to have_css('.admin-tutorial-card', count: 1)
  end
end
