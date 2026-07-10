class Public::UsersController < Public::ApplicationController
  allow_unauthenticated_access only: [:new, :create] 
  before_action :ensure_guest_user, only: [:edit]
  def new
    @user = User.new
  end
 
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_session_path, notice: "ユーザー登録が完了しました！続けてログインしてください。"
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id) 
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def withdraw
    @user = Current.user 
    @user.update!(is_active: false)
    terminate_session
    redirect_to root_path, notice: "退会処理が完了しました。"
  end

  private
 
  def user_params
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to public_user_path(Current.user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end  

end
