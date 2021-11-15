class PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.new(post_comment_params)
    @post_comment.user_id = current_user.id
    @post_comment.post_id = @post.id
    @post_comment.save
    # app/views/post_comments/create.js.erbを参照
  end

  def destroy
    @post = Post.find(params[:post_id])
    post_comment = @post.post_comments.find(params[:id])
    post_comment.destroy
    # app/views/post_comments/destroy.js.erbを参照
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
