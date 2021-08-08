class UsersController < ApplicationController
  protect_from_forgery
  
  def index
    @users = User.all
    @user = User.find_by(params[:id])
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
    @user = User.new(
		name: params[:name],
		email: params[:email],
		password: params[:password],
		repassword: params[:repassword],
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
      if @user.update(params.require(:user).permit(:name, :email, :password, :repassword))
        flash[:notice] = "ユーザーIDが「#{@user.id}」の情報を更新しました"
        redirect_to :users
      else
        render "edit"
      end
    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
   end
  end
end