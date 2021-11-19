class RelationshipsController < ApplicationController

  def create
    follow = current_user.active_relationships.build(follower_id: params[:user_id])
    follow.save
    redirect_to request.referer
  end

  def destroy
    follow = current_user.active_relationships.find_by(follower_id: params[:user_id])
    follow.destroy
    redirect_to request.referer
  end

  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings.page(params[:page]).per(10).reverse_order
  end

  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers.page(params[:page]).per(10).reverse_order
  end

end
