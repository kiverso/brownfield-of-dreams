require 'rails_helper'

RSpec.describe Follow, type: :model do
  describe 'instance_methods' do
    it 'initialize' do
      invite = Invite.new({name: 'Kyle Iverson'}, {name: 'Jeff', email: 'jeff@example.com'})

      expect(invite).to be_an_instance_of(Invite)

      expect(invite.inviter_name).to eq('Kyle Iverson')
      expect(invite.recipient_name).to eq('Jeff')
      expect(invite.recipient_email).to eq('jeff@example.com')
    end
  end
end