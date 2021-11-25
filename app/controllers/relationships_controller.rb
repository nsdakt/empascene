class RelationshipsController < ApplicationController
  before_action :authenticate_user!

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
    # users = User.where.not(is_deleted: true)
    @user = User.find(params[:user_id])
    @users = @user.followings.where.not(is_deleted: true).page(params[:page]).per(10).reverse_order
  end

  def followers
    # users = User.where.not(is_deleted: true)
    @user = User.find(params[:user_id])
    @users = @user.followers.where.not(is_deleted: true).page(params[:page]).per(10).reverse_order
  end
end
