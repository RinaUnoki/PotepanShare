class UsersController < ApplicationController
  protect_from_forgery
  
  def index
    @users = User.all
    @user = User.find_by(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def user_params
    params.require(:user).permit(:image)
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end

  
  def create
    @user = User.new(
		name: params[:name],
		email: params[:email],
		password: params[:password],
		repassword: params[:repassword],
		introduction: params[:introduction],
		image: params[:image],
		image_name: "default_user.jpg",
	)

    #@user = User.new(params.require(:user).permit(:name, :email, :password, :repassword,:image_name))
      if @user.save
        flash[:notice] = "ユーザーを新規登録しました"
        redirect_to :users
      else
        render "new"
      end
  end
  
   def update
    @user = User.find(params[:id])
      if @user.update(params.require(:user).permit(:name, :email, :password, :repassword, :introduction))
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