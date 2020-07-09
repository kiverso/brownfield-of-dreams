class Invite
  attr_reader :inviter_name,
              :recipient_name,
              :recipient_email
  def initialize(inviter, recipient)
    @inviter_name = inviter[:name]
    @recipient_name = recipient[:name]
    @recipient_email = recipient[:email]
  end
end