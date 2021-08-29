class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only:[:edit, :update]

  # protect_from_forgery
  # 投稿データの保存
  def create
    @book = Book.new(book_params)
    # ストロングパラメーターも引数の値に加える※schema.rbでカラムを確認することができる
    @book.user_id = current_user.id
    if @book.save
     flash[:notice] ="You have created book successfully."
     redirect_to book_path(@book.id)
    else
     @books = Book.all
     @user = current_user
     render :index
    # renderの後に続く引数は
    end
  end

  def index
    @books = Book.all
    @user = current_user
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    # アソシエーションの関係
    @books = Book.new
    @new_book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] ="You have updated book successfully."
      # デバイス以外には追記
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end
# bookを保存、アップデートする際に必要になってくる
  def correct_user
    @book = Book.find(params[:id])
    redirect_to books_path unless @book.user == current_user
  end

end
