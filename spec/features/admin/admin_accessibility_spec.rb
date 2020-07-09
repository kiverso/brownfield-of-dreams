require 'rails_helper'

RSpec.describe 'As an admin' do
  it 'can not access edit videos path' do
    admin = create(:admin)

    tutorial1 = create(:tutorial, title: "Abra-Kadabra")
    video = create(:video, title: "Zebra man", tutorial: tutorial1)
    video2 = create(:video, title: "Anteater Monopoly", tutorial: tutorial1)
    video3 = create(:video, title: "All Things Magic", tutorial: tutorial1)
    video4 = create(:video, title: "Magic School Bus", tutorial: tutorial1)
    video5 = create(:video, title: "Harry Potter", tutorial: tutorial1)

    expect{ visit "/admin/tutorials/#{tutorial1.id}/edit" }.to raise_error(ActionController::RoutingError)
  end
  it 'can not access edit videos path' do
    visit '/get_started'
  end
end
