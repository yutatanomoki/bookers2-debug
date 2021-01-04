class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
  end

  def destroy
  end
end
