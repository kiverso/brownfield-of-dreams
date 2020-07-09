class User < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :videos, through: :user_videos
  has_many :tutorials, through: :videos
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true
  validates :password, presence: true
  validates :first_name, presence: true
  enum role: { default: 0, admin: 1 }
  has_secure_password

  def bookmarks
    videos.joins(:tutorial).select('videos.title,
                                    videos.position,
                                    tutorials.id as t_id,
                                    tutorials.title as t_title')
          .order('t_id, videos.position')
  end

  def find_repos
    github_service = GithubService.new
    repo_data = github_service.find_data(self, 'repos')
    repos = repo_data.map do |repo|
      Repo.new(repo[:name], repo[:html_url])
    end
    repos.first(5)
  end

  def find_followers
    github_service = GithubService.new
    follower_data = github_service.find_data(self, 'followers')
    follower_data.map do |follower|
      Follow.new(follower[:login], follower[:html_url])
    end
  end

  def find_following
    github_service = GithubService.new
    following_data = github_service.find_data(self, 'following')
    following_data.map do |follow|
      Follow.new(follow[:login], follow[:html_url])
    end
  end

  def confirm_email
    update_attribute(:email_activation, 'Confirmed')
  end
end
