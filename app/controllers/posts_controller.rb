class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def index
    @post = Post.all
  end
    
  def show
    @post = Post.find(params[:id])
  end
    
  def create
    @post = current_user.posts.build(permit_post)
    if @post.save
      flash[:success] = "Success!"
      redirect_to post_path(@post)
    else
      flash[:error] = @post.errors.full_messages
      redirect_to new_post_path
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user == current_user
      @post.destroy
      redirect_to posts_path, notice: "The post has been deleted!"
    else
      redirect_to posts_path, alert: "You are not authorized to delete this post."
    end
  end
  

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(permit_post)
      flash[:success] = "Post was successfully updated."
      redirect_to @post, notice: ''
    else
      render :edit
    end
  end  
    
  private
    def permit_post
      params.require(:post).permit(:image, :description)
    end
end
