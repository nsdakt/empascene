class UsersController < ApplicationController

 before_action :authenticate_user!
 before_action :set_user, only: [:favorites]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(10).reverse_order
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
     if @user.update(user_params)
       flash[:success] = "変更を保存しました！"
       redirect_to user_path(current_user.id)
     else
       flash[:warning] = "※使用できないアカウント名です"
       render :edit
     end
  end

  def favorites
    @user = User.find(params[:id])
    byebug
    favorites = Favorite.where(user_id: @user).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
