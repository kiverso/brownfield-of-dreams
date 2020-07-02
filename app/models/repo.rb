class Repo
attr_reader :name, :url
  def initialize(name, url)
    @name = name
    @url = "http://www.github.com/#{url}"
  end
end
