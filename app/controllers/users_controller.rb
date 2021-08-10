class UsersController < ApplicationController
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(params.require(:user).permit(:name, :email, :password, :password_confirmation, :introduction, :image_name))
      if @user.save
        flash[:notice] = "ユーザーを新規登録しました"
        redirect_to :users
      else
        render "new"
      end
  end
  
   def update
    @user = User.find(params[:id])
      if @user.update(params.require(:user).permit(:name, :email, :password, :password_confirmation,  :introduction, :image_name))
        flash[:notice] = "情報を更新しました"
        redirect_to :users
      else
        render "edit"
      end
  end
  
  def login_form
  end
  
  def login
    # 入力内容と一致するユーザーを取得し、変数@userに代入してください
    @user = User.find_by(email: params[:email], password: params[:password])
    # @userが存在するかどうかを判定するif文を作成してください
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to :users
    else
       @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end
  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to :users
  end
end