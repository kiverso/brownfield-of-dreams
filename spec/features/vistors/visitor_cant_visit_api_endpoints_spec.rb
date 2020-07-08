require 'rails_helper'

RSpec.describe 'As a regular visitor' do
  it 'I can not visit the api admin routes' do

    tutorial = create(:tutorial)

    # visit "/admin/api/v1/tutorial_sequencer/#{tutorial.id}"
    #
    # expect(page).to raise_error

  end
end
