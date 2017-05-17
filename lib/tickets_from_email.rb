class TicketsFromEmail
  def initialize(email)
    @email = email
  end

  def find_or_create_user
    User.find(email: email) || create_user
  end

  def create_user
    user = User.new

    token, enc = Devise.token_generator.generate(User, :reset_password_token)
    user.reset_password_token = enc
    user.reset_password_sent_at = Time.now.utc

    user.email = params[:user_email]
    user.name = @email.from[:name].blank? ? @email.from[:token].gsub(/[^a-zA-Z]/, '') : @email.from[:name]
    user.password = User.create_password
    if user.save
      UserMailer.new_user(user.id, token).deliver_later
    end
    user
  end
end
