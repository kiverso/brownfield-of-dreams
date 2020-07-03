require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe 'class methods' do
    it 'authorized_for_viewer' do
      user1 = create(:user)
      visitor = nil

      tutorial1 = create(:classroom_tutorial)
      tutorial2 = create(:tutorial)

      video1 = create(:video, tutorial_id: tutorial1.id)
      video2 = create(:video, tutorial_id: tutorial1.id)
      video3 = create(:video, tutorial_id: tutorial2.id)
      video4 = create(:video, tutorial_id: tutorial2.id)
\
      expect(Tutorial.authorized_for_viewer(user1)).to eq([tutorial1, tutorial2])
      expect(Tutorial.authorized_for_viewer(visitor)).to eq([tutorial2])
    end
    it 'import_video' do
      tutorial1 = create(:classroom_tutorial)

      admin = User.create!(email: 'admin@example.com', password: 'asdf123', first_name: 'admin1', role: 1)
      video1 = create(:video)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      service = YoutubeService.new

      playlist_video_data = service.import_playlist_items('PLJa35fj7DMyBB_BlY0Uwr4Ji1NlbvaVEi', nil)

      playlist_video_data[:items].each {|video| tutorial1.import_video(video)}

      expect(tutorial1.videos.count).to eq(3)

      expect(tutorial1.videos[0]).to be_an_instance_of(Video)
    end
  end
end
