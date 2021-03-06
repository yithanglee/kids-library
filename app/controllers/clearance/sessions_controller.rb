class Clearance::SessionsController < Clearance::BaseController
  if respond_to?(:before_action)
    before_action :redirect_signed_in_users, only: [:new]
    skip_before_action :require_login,
      only: [:create, :new, :destroy],
      raise: false
    skip_before_action :authorize,
      only: [:create, :new, :destroy],
      raise: false
  else
    before_filter :redirect_signed_in_users, only: [:new]
    skip_before_filter :require_login,
      only: [:create, :new, :destroy],
      raise: false
    skip_before_filter :authorize,
      only: [:create, :new, :destroy],
      raise: false
  end

  def create
    @user = User.find_by(member_id: params[:session][:member_id])
    if @user == nil
      flash.now.alert = "Please key in a valid member id."
      render template: "sessions/new"
    elsif @user.member_id == 'Pending'
      flash.now.alert = "Your account requires librarian to approve."
      render template: "sessions/new"
    else
      if @user.authenticated?(params[:session][:password])
        sign_in(@user) do |status|
          if status.success?
            redirect_back_or url_after_create
          else
            flash.now.notice = status.failure_message
            render template: "sessions/new", status: :unauthorized
          end
        end
      else
        flash.now.alert = "Wrong password."
        render template: "sessions/new"
      end
    end



  end

  def destroy
    sign_out
    redirect_to url_after_destroy
  end

  def new
    render template: "sessions/new"
  end

  private

  def redirect_signed_in_users
    if signed_in?
      redirect_to url_for_signed_in_users
    end
  end

  def url_after_create
    Clearance.configuration.redirect_url
  end

  def url_after_destroy
    sign_in_url
  end

  def url_for_signed_in_users
    url_after_create
  end
end