require 'rails_helper'

RSpec.describe 'as an admin' do
  before(:each) do
    @admin = create(:user, role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end
  it 'can create a new tutorial' do
    visit '/admin/tutorials/new'

    fill_in 'Title', with: 'Fantastic Cats'
    fill_in 'Description', with: 'These cats sure can dance'
    fill_in 'Thumbnail', with: 'https://static.boredpanda.com/blog/wp-content/uploads/2018/11/funny-dancing-cats-11-5be421492f1ca__700.jpg'
    click_on('Save')

    tutorial = Tutorial.last

    expect(current_path).to eq("/tutorials/#{tutorial.id}")
    expect(page).to have_content('Successfully created tutorial.')
  end
  it 'has an error flash message if the tutorial is not filled in correctly' do
    visit '/admin/tutorials/new'

    fill_in 'Description', with: 'These cats sure can dance'
    fill_in 'Thumbnail', with: 'https://static.boredpanda.com/blog/wp-content/uploads/2018/11/funny-dancing-cats-11-5be421492f1ca__700.jpg'
    click_on('Save')

    expect(current_path).to eq("/admin/tutorials/new")
    expect(page).to have_content("Title can't be blank")
  end
end
