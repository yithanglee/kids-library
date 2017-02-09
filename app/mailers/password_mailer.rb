class PasswordMailer < ApplicationMailer

  default from: 'damien@rubysmith.my'

  def reset_email(user)
    @user = user
    @url = set_new_password_url(@user.remember_token, :only_path => 'false')
    mail(to: @user.email , subject: "Here's your reset password link!")

  end
end
