class UsersController < ApplicationController

before_action :set_user, only:[:show, :edit, :update]

def show
	
end

def edit

end


def update
 
      if @user.update(user_params)
        redirect_to root_url, notice: 'User was successfully updated.'
      else
      	redirect_to root_url, alert: 'User was not successfully updated.'      
      end

end

private

def set_user

	@user = User.find(params[:id])
	
end

def user_params

	params.require(:user).permit(:name, :email, :password)
	
end

end
