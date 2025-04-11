class PostsController < ApplicationController
  def index
    @posts = Post.where(is_public: true).order(created_at: :desc).includes(:user)
  end
end
