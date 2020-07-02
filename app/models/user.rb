class User < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates :password, presence: true
  validates :first_name, presence: true
  enum role: { default: 0, admin: 1 }
  has_secure_password

  def find_repos
    github_service = GithubService.new
    repo_data = github_service.find_data(self, 'repos')
    repos = repo_data.map do |repo|
      Repo.new(repo[:name], repo[:html_url])
    end
    repos.first(5)
  end
end
