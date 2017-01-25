class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_login
  # GET /users
  # GET /users.json
  def index
    if params[:sort_by].nil?
       sort = "member_id desc"
    elsif params[:sort_by]=="member_id"
      sort = "member_id "+ params[:order]
    elsif params[:sort_by]=="name"
      sort = "name "+ params[:order]  
    end 

    if !current_user.is_admin?
    @users = User.where(id: current_user.id)
    else
    @users = User.all.order(sort).paginate(:page => params[:page], :per_page => 15)
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show

    @loans = @user.loans.where(has_returned: false).order("return_date ASC" )
    @loans_returned = @user.loans.where(has_returned: true)

  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    search_params = params.permit(:search_term)
    @users = User.search(search_params)
    if @users.blank?
      redirect_to users_path, flash:{alert: "no successful search result"}
    else
      @users = @users.order('member_id desc').paginate(:page => params[:page], :per_page => 20)
      render :index
    end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :ic, :phone, :email, :birthday, :member_id, :password, :user_type, :chinese_name, :line1, :line2, :line3, :postcode, :city, :state)
    end
end
