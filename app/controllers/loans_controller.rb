class LoansController < ApplicationController
  before_action :set_loan, only: [:show, :edit, :update, :destroy, :return_date_extend, :book_return]

  # GET /loans
  # GET /loans.json
  def index
    
    if current_user == nil
      require_login
    elsif current_user.is_admin?
      @loans = Loan.all.where(has_returned: false).order('return_date ASC')
    elsif !current_user.is_admin?
      @loans = Loan.where(user_id: current_user.id)
    end
    
  end

  # GET /loans/1
  # GET /loans/1.json
  def show
  end

  # GET /loans/new
  def new
        a = Time.zone.today
    @loan = Loan.new(loan_date: a, return_date: a+7)
    user = User.find_by(member_id: params[:user])
    if user.nil?
    else
    @loans = user.loans.where(has_returned: false).order('return_date ASC')
    end
  end

  # GET /loans/1/edit
  def edit
  end

  # POST /loans
  # POST /loans.json
  def create
    @loan = Loan.new(loan_params)
    respond_to do |format|
      if @loan.save
        format.html { redirect_to new_loan_path(:user => @loan.user.member_id) , notice: 'Loan was successfully created.' }
        format.json { render :show, status: :created, location: @loan }
      else
        format.html { redirect_to books_path, alert: @loan.errors.full_messages.join }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /loans/1
  # PATCH/PUT /loans/1.json
  def update
    respond_to do |format|
      if @loan.update(loan_params)
        format.html { redirect_to @loan, notice: 'Loan was successfully updated.' }
        format.json { render :show, status: :ok, location: @loan }
      else
        format.html { render :edit }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  def return_date_extend

    @loan.return_date_extend
    if current_user.is_admin?
      if @loan.errors.messages.first.nil?
        @message = "Loan extension was succcessful."
       respond_to do |format|
        format.html { redirect_to loans_path, notice: @message }
        format.json { head :no_content }
        end
      else
        @message = @loan.errors.messages.first[1]
       respond_to do |format|
        format.html { redirect_to loans_path, alert: @message }
        format.json { head :no_content }
        end
      end 
    else
      if @loan.errors.messages.first.nil?
        @message = "Loan extension was succcessful."
       respond_to do |format|
        format.html { redirect_to root_path, notice: @message }
        format.json { head :no_content }
        end
      else
        @message = @loan.errors.messages.first[1]
       respond_to do |format|
        format.html { redirect_to root_path, alert: @message }
        format.json { head :no_content }
        end
      end   
    end
  end


  def book_return

    @loan.book_return

    if @loan.errors.messages.first.nil?
      @message = "Return was succcessful."
     respond_to do |format|
      format.html { redirect_to new_loan_path(user: @loan.user.member_id), notice: @message }
      format.json { head :no_content }
    end
    else
      @message = @loan.errors.messages.first[1]
     respond_to do |format|
      format.html { redirect_to loans_path, alert: @message }
      format.json { head :no_content }
    end
    end
    
  end

  def history
    if current_user == nil
      require_login
    elsif current_user.is_admin?
      @loans = Loan.all.where(has_returned: true).order('loan_date DESC')
    end
  end

  def search_book
      @user = User.find_by(member_id: params[:user])
      @book = Book.super_search(params).first
    respond_to do |format|
      format.html { render 'new' }
      format.js
    end  

  end



  # DELETE /loans/1
  # DELETE /loans/1.json
  def destroy
    @loan.destroy
    respond_to do |format|
      format.html { redirect_to loans_url, notice: 'Loan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loan
      @loan = Loan.find(params[:id])
    end



    # Never trust parameters from the scary internet, only allow the white list throu gh.
    def loan_params
      params.require(:loan).permit(:loan_date, :return_date, :book_id, :user_id, :user)
    end
end
