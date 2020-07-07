class Follow
  attr_reader :name, :url
  def initialize(name, url)
    @name = name
    @url = url
  end

  def in_database?
    User.exists?(url: self.url)
  end
end
