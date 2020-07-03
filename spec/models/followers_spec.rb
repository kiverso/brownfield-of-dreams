require 'rails_helper'

RSpec.describe Follow, type: :model do
  describe 'instance_methods' do
    it 'initialize' do
      follower = Follow.new('test_follower', 'github.com/test_follower')

      expect(follower).to be_an_instance_of(Follow)
      expect(follower.name).to eq('test_follower')
      expect(follower.url).to eq('github.com/test_follower')
    end
  end
end
