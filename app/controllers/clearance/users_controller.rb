class Clearance::UsersController < Clearance::BaseController
  if respond_to?(:before_action)
    before_action :redirect_signed_in_users, only: [:create, :new]
    skip_before_action :require_login, only: [:create, :new], raise: false
    skip_before_action :authorize, only: [:create, :new], raise: false
  else
    before_filter :redirect_signed_in_users, only: [:create, :new]
    skip_before_filter :require_login, only: [:create, :new], raise: false
    skip_before_filter :authorize, only: [:create, :new], raise: false
  end

  def new
    @user = user_from_params
    render template: "users/new"
  end

  def create
    @user = user_from_params

    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      render template: "users/new"
    end
  end

  private

  def avoid_sign_in
    warn "[DEPRECATION] Clearance's `avoid_sign_in` before_filter is " +
      "deprecated. Use `redirect_signed_in_users` instead. " +
      "Be sure to update any instances of `skip_before_filter :avoid_sign_in`" +
      " or `skip_before_action :avoid_sign_in` as well"
    redirect_signed_in_users
  end

  def redirect_signed_in_users
    if signed_in?
      redirect_to Clearance.configuration.redirect_url
    end
  end

  def url_after_create
    Clearance.configuration.redirect_url
  end

  def user_from_params
    # email = user_params.delete(:email)
    # password = user_params.delete(:password)
    # name = user_params.delete(:name)
    # ic = user_params.delete(:ic)
    # member_id = user_params.delete(:member_id)
    # phone = user_params.delete(:phone)
    # birthday = user_params.delete(:birthday)


    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = user_params[:email]
      user.password = user_params[:password]
      user.name = user_params[:name]
      user.ic = user_params[:ic]
      user.member_id = user_params[:member_id]
      user.phone = user_params[:phone]
      user.birthday = user_params[:birthday]

    end
  end

  def user_params
    if params[Clearance.configuration.user_parameter].nil?
     Hash.new
    else
    # params[Clearance.configuration.user_parameter]
    params.require(:user).permit(:name, :ic, :phone, :email, :birthday, :member_id, :password)
    end
  end
end