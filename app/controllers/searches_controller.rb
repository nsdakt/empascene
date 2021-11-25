class SearchesController < ApplicationController

  before_action :authenticate_user!

  def search
    @model = params["model"]
    @content = params["content"]
    @method = params["method"]
    @records = search_for(@model, @content, @method).page(params[:page]).per(10).reverse_order
  end

  private

  def search_for(model, content, method)
    if model == 'user'
      users = User.where.not(is_deleted: true)
      if method == 'perfect'
        users.where(name: content)
      elsif method == 'foward'
        users.where('name LIKE ?', '%'+content+'%')
      elsif method == 'backward'
        users.where('name LIKE ?', '%'+content+'%')
      else
        users.where('name LIKE ?', '%'+content+'%')
      end
    elsif model == 'post'
      posts = Post.joins(:user).where.not("users.is_deleted = ?", true)
      if method == 'perfect'
        posts.where(title: content)
        posts.where(body: content)
      elsif method == 'foward'
        posts.where('title LIKE ?', '%'+content+'%')
        posts.where('body LIKE ?', '%'+content+'%')
      elsif method == 'backward'
        posts.where('title LIKE ?', '%'+content+'%')
        posts.where('body LIKE ?', '%'+content+'%')
      else
        posts.where('title LIKE ?', '%'+content+'%')
        posts.where('body LIKE ?', '%'+content+'%')
      end
    end
  end
end
