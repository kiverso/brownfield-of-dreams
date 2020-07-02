require 'rails_helper'

RSpec.describe Repo, type: :model do
  describe 'instance_methods' do
    it 'initialize' do
      repo = Repo.new('test_repo', 'github.com/test_repo')

      expect(repo).to be_an_instance_of(Repo)
      expect(repo.name).to eq('test_repo')
      expect(repo.url).to eq('github.com/test_repo')
    end
  end
end