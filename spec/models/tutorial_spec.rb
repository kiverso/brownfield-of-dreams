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
  end
end
