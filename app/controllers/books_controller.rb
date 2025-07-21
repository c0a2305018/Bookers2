class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def new
    @books=Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      @user = current_user
      @books = Book.all
      render 'users/show'
    end
  end
  
  

  def index
    @login_user = current_user
    @books= Book.includes(:user).all
    @book= Book.new
    @users = User.all 
    @books = Book.all
    @user = current_user
    @books = Book.all.includes(:user, :book_comments)
    @comment = BookComment.new
  end

  def edit
    is_matching_login_user
    @book=Book.find(params[:id])
    @user = @book.user
    @books = Book.all
  end

  def show
    @login_user = current_user
    @book =Book.find(params[:id])
    @user = @book.user
    @new_book = Book.new(params[:book])
    @books = @user.books

    @comment = BookComment.new
  end

  def update
    is_matching_login_user
    @book = Book.find(params[:id])
    
    
    @book.user_id = current_user.id
    if @book.update(book_params)
      flash[:notice]="You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      @books=Book.includes(:user).all
      @users=User.all
      render :edit
    end
  end

  def destroy
    is_matching_login_user
    @book=Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body, :image)
  end

  def is_matching_login_user
    @book = Book.find_by(id: params[:id])
    unless @book && @book.user_id == current_user.id
      flash[:alert] = "他のユーザーの書籍を編集/削除することはできません。"
      redirect_to books_path
    end
  end
end
