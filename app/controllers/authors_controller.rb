class AuthorsController < ApplicationController
  before_action :set_authors
  before_action :set_author, only: [:show, :edit, :update, :destroy]

  # GET publishers/1/authors
  def index
    @authors = Author.all
  end

  # GET publishers/1/authors/1
  def show
  end

  # GET publishers/1/authors/new
  def new
    @author = Author.new
  end

  # GET publishers/1/authors/1/edit
  def edit
  end

  # POST publishers/1/authors
  def create
    @author = Author.new(author_params)

    if @author.save
      redirect_to([@author], notice: 'Author was successfully created.')
    else
      render action: 'new'
    end
  end

  # PUT publishers/1/authors/1
  def update
    if @author.update_attributes(author_params)
      redirect_to([@author], notice: 'Author was successfully updated.')
    else
      render action: 'edit'
    end
  end

  # DELETE publishers/1/authors/1
  def destroy
    @author.destroy

    redirect_to authors_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_authors
      # @publisher = Publisher.find(params[:publisher_id])
    end

    def set_author
      @author = Author.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def author_params
      params.require(:author).permit(:name)
    end
end
