class GithubService
  require 'pry'; binding.pry
  def conn
    Faraday.get(url: "https://api.github.com/user/repos") do |f|
      f.headers: ['Authorization'] = 'token 6388d169a8e57527eaab141072d11b649dec2262'
    end
  end
end