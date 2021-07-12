class BooksController < ApplicationController
  before_action :baria_user, only: [:edit, :destroy, :update]
  

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @books = Book.all.page(params[:page]).reverse_order
    if @book.save
      flash[:notice] = 'You have created book successfully.'
      redirect_to book_path(@book.id)
    else 
      render :index
    end  
  end
  
  def index
    @books = Book.all.page(params[:page]).reverse_order
    #binding.pry
    @book = Book.new
    @user = current_user
    @users = User.all
  end
  
  def edit  
    @book = Book.find(params[:id])
  end

  def show
    @books = Book.find(params[:id])
    @users = User.all
    @book = Book.new
    @user = @books.user
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
       flash[:notice] = "You have updated book successfully."
       redirect_to book_path(@book.id)
    else
       render :edit
    end   
  end  
  
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def baria_user
    unless Book.find(params[:id]).user.id.to_i == current_user.id
           redirect_to books_path 
    end
  end
end
