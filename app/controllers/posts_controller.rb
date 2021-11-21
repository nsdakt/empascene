class PostsController < ApplicationController

  before_action :authenticate_user!

  def index
    @posts = Post.page(params[:page]).per(10).reverse_order
    @user = current_user
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new
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
    @post = Post.find(params[:id])
    if @post.user == current_user
      render "edit"
    else
      redirect_to post_path
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.user_id = current_user.id
    if @post.update(post_params)
     flash[:notice] = "投稿を編集しました！"
     redirect_to post_path(@post.id)
    else
     render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end


  def search
    @user = current_user
  end

  private

  def post_params
    params.require(:post).permit(:title, :song, :artist, :body, :post_image)
  end

end