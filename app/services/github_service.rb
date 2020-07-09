class GithubService
  def find_data(user, data)
    get_json("user/#{data}", user)
  end

  def get_json(url, user)
    response = conn.get(url, nil, { Authorization: "token #{user.token}" })
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def conn
    Faraday.new(url: 'https://api.github.com')
  end
end
