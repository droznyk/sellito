class PostsController < ApplicationController
  before_action :fetch_post, only: %i(show edit update destroy)

  def index
      @posts = Post.all.reverse
  end

  def user_posts
    @posts = current_user.posts
  end

  def new
    @post = Post.new
  end

  def create
    return unless post_params[:user_id]== current_user.id.to_s
    @post = Post.new(post_params)
    if @post.valid?
      @post.save
      flash[:notice] = 'Post created!'
      redirect_to @post
    else
      flash[:errors] = @post.errors.full_messages
      redirect_back(fallback_location: root_path)
    end
  end

  def show; end

  def edit; end

  def update
    @post.update_attributes(post_params)
    redirect_to @post
  end

  def destroy
    @post.destroy
    flash[:notice] = "Post #{@post.title} deleted"
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :expiration_date, :user_id)
  end

  def fetch_post
    @post = Post.find(params[:id])
  end

end
