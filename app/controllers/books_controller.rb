class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @books = Book.all
    @users = User.all
    @user = @book.user
    @book_comment = BookComment.new
  end

  def index
    @books = Book.all
    @book = Book.new
    @users = @users = User.all
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      @books = Book.all
      @users = @users = User.all
      @user = current_user
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      @books = Book.all
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:notice] = "Book was successfully destroyed."
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)  if params[:book].present?
  end
  
end
