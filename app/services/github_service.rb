class GithubService

  def find_repos(user)
    repos = get_json('user/repos', user)
    binding.pry
  end

  private

  def get_json(url, user)    
    response = conn.get(url, nil, {Authorization: "token #{user.token}"})
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.github.com")
  end
end