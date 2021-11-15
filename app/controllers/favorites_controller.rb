class FavoritesController < ApplicationController
  before_action :post_params

  def create
    post = Post.find(params[:post_id])
    favorite = Favorite.new(post_id: post.id)
    favorite.user_id =current_user.id
    favorite.save
    # app/views/favorites/create.js.erbを参照
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = Favorite.find_by(post_id: post.id)
    favorite.user_id =current_user.id
    favorite.destroy
    # app/views/favorites/destroy.js.erbを参照
  end

  private
  # post/show画面で定義した@postを反映させる
  def post_params
    @post = Post.find(params[:post_id])
  end

end
