class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = @book.id

    if @comment.save
      redirect_to book_path(@book), notice: "コメントを投稿しました。"
    else
      @comments = @book.book_comments.includes(:user)
      render 'books/show'
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    comment = @book.book_comments.find(params[:id])
    comment.destroy
    redirect_to book_path(@book), notice: "コメントを削除しました。"
  end
  
  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
