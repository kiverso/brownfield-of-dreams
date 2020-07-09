require 'rails_helper'

RSpec.describe 'As a user that is connected to github in the system' do
  before(:each) do
    @josh = User.create!(email: 'josh@example.com', first_name: 'Josh', last_name: 'Gilmore', password: '12345', url: 'https://github.com/cgaddis36', token: ENV["github_api_token_c"])
    @dione = User.create!(email: 'dione@example.com', first_name: 'Dione', last_name: 'Lopez', password: '123885', url: 'https://github.com/kiverso', token: ENV["github_api_token_k"])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@josh)
  end
  it 'I can add other users in the system that are following on Github' do
    visit dashboard_path

    within "#following-meghanstovall" do
      expect(page).to_not have_button("Add meghanstovall as Friend")
    end

    within "#following-kiverso" do
      expect(page).to have_button("Add kiverso as Friend")
      click_button("Add kiverso as Friend")
    end

    expect(page).to have_content("Successfully added Dione Lopez as a friend")

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_css('#friend', count: 1)
  end

  it 'I can add other users in the system that are also followers on Github' do
    visit dashboard_path

    within "#follower-kiverso" do
      expect(page).to have_button("Add kiverso as Friend")
      click_button("Add kiverso as Friend")
    end

    within "#follower-meghanstovall" do
      expect(page).to_not have_button("Add meghanstovall as Friend")
    end

    expect(page).to have_content("Successfully added Dione Lopez as a friend")

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_css('#friend', count: 1)
  end
end
