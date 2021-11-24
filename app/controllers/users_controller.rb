class UsersController < ApplicationController

 before_action :authenticate_user!
 before_action :set_user, only: [:favorites]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(5).reverse_order
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
   if @user.update(user_params)
     flash[:success] = "変更を保存しました！"
     redirect_to user_path(current_user.id)
   else
     render :edit
   end
  end

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.joins(:user).where.not("users.is_deleted = ?", true).page(params[:page]).per(5).reverse_order
  end

  # 論理削除
  def withdrawal
    @user = User.find(params[:id])
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: true)
    reset_session
    flash[:delete] = "退会処理が完了しました"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :is_deleted)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
