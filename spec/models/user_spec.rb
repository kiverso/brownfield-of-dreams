require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:password)}
  end

  describe 'relationships' do
    it { should have_many(:user_videos).dependent(:destroy)}
    it { should have_many(:friendships)}
    it { should have_many(:friends).through(:friendships)}
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
        expect(follower).to be_an_instance_of(Follow)
        expect(follower.name).to_not be_nil
        expect(follower.url).to_not be_nil
      end
    end

    it 'find_followings' do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0, token: ENV["github_api_token_c"])

      user.find_following.each do |follow|
        expect(follow).to be_an_instance_of(Follow)
        expect(follow.name).to_not be_nil
        expect(follow.url).to_not be_nil
      end
    end

    it 'bookmarks' do
      user = User.create(email: 'user@email.com', password: 'password',
                         first_name:'Jim', role: 0,
                         token: ENV["github_api_token_c"])

      tutorial1 = create(:tutorial, title: "Abra-Kadabra")
      tutorial2 = create(:tutorial, title: "Zookeeper")
      video = create(:video, title: "Zebra man", position: 2, tutorial: tutorial2)
      video2 = create(:video, title: "Anteater Monopoly", position: 1, tutorial: tutorial2)
      video3 = create(:video, title: "All Things Magic", tutorial: tutorial1)
      video4 = create(:video, title: "Magic School Bus", position: 2, tutorial: tutorial1)
      video5 = create(:video, title: "Harry Potter", position: 1, tutorial: tutorial1)

      UserVideo.create(user_id: user.id, video_id: video.id )
      UserVideo.create(user_id: user.id, video_id: video2.id )
      UserVideo.create(user_id: user.id, video_id: video3.id )
      UserVideo.create(user_id: user.id, video_id: video4.id )
      UserVideo.create(user_id: user.id, video_id: video5.id )

      bookmarks = user.bookmarks

      expect(bookmarks.first.title).to eq(video3.title)
      expect(bookmarks[1].title).to eq(video5.title)
      expect(bookmarks.last.title).to eq(video.title)
    end

    it 'confirm_email' do
      user = create(:user)

      expect(user.email_activation).to be_nil

      user.confirm_email

      expect(user.email_activation).to eq("Confirmed")
    end
  end
end
