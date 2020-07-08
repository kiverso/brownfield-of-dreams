require 'rails_helper'

RSpec.describe 'As an admin' do
  it 'I can edit videos' do
    admin = create(:admin)

    tutorial1 = create(:tutorial, title: "Abra-Kadabra")
    video = create(:video, title: "Zebra man", tutorial: tutorial1)
    video2 = create(:video, title: "Anteater Monopoly", tutorial: tutorial1)
    video3 = create(:video, title: "All Things Magic", tutorial: tutorial1)
    video4 = create(:video, title: "Magic School Bus", tutorial: tutorial1)
    video5 = create(:video, title: "Harry Potter", tutorial: tutorial1)






  end
end
