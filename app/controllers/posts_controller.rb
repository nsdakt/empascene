class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
  end

  def new
   @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:success] = "投稿しました！"
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :song, :artist, :body, :post_image)
  end

end