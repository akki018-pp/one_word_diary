class PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @today_posts = current_user.posts_by_time_slot_for_today
  end

  def new
    @post = Post.new
  end

  def create
    slot = current_time_slot

    @post = current_user.posts.build(post_params)
    @post.time_slot = slot

    if @post.save
      redirect_to posts_path, notice: t('defaults.flash_message.created')
    else
      flash.now[:alert] = t('defaults.flash_message.not_created')
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to posts_path, notice: t('defaults.flash_message.updated')
    else
      flash.now[:alert] = t('defaults.flash_message.not_updated')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy!
    flash[:notice] = t('defaults.flash_message.deleted')
    redirect_to posts_path, status: :see_other
  end

  def log
    @posts = current_user.posts.order(created_at: :desc).group_by { |post| post.created_at.to_date }
  end

  private

  def post_params
    params.require(:post).permit(:tweet)
  end
end
