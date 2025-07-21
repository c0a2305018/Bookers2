class PostCommentsController < ApplicationController
    def create
      @book = Book.find(params[:book_id])
      @comment = current_user.post_comments.new(post_comment_params)
      @comment.book_id = @book.id
  
      if @comment.save
        redirect_to book_path(@book), notice: "コメントを投稿しました。"
      else
        @comments = @book.post_comments.includes(:user)
        render 'books/show'
      end
    end

    def destroy
        PostComment.find(params[:id]).destroy
        redirect_to book_path(params[:book_id])
    end
    private
  
    def post_comment_params
      params.require(:post_comment).permit(:comment)
    end
  end
  