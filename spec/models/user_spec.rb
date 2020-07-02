require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:password)}
  end

  describe 'relationships' do
    it { should have_many(:user_videos).dependent(:destroy)}
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name:'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end
  describe 'instance methods' do
    it "find_repos" do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0, token: ENV["github_api_token_c"])

      expect(user.find_repos.count).to eq(5)
      user.find_repos.each do |repo|
        expect(repo).to be_an_instance_of(Repo)
      end
    end

    it 'find_followers' do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0, token: ENV["github_api_token_c"])

      user.find_followers.each do |follower|
        expect(follower).to be_an_instance_of(Follower)
      end
    end
  end
end
