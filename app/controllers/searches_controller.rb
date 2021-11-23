class SearchesController < ApplicationController

  before_action :authenticate_user!

  def search
    @model = params["model"]
    @content = params["content"]
    @method = params["method"]
    @records = search_for(@model, @content, @method)
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
      if method == 'perfect'
        Post.where(title: content)
        Post.where(body: content)
      elsif method == 'foward'
        Post.where('title LIKE ?', '%'+content+'%')
        Post.where('body LIKE ?', '%'+content+'%')
      elsif method == 'backward'
        Post.where('title LIKE ?', '%'+content+'%')
        Post.where('body LIKE ?', '%'+content+'%')
      else
        Post.where('title LIKE ?', '%'+content+'%')
        Post.where('body LIKE ?', '%'+content+'%')
      end
    end
  end
end
