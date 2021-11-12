class FavoritesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    favorite = Favorite.new(post_id: post.id)
    favorite.user_id =current_user.id
    favorite.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = Favorite.find_by(post_id: post.id)
    favorite.user_id =current_user.id
    favorite.destroy
    redirect_back(fallback_location: root_path)
  end
end
