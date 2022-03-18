class PostsController < ApplicationController
  
  def new
    @post = Post.new
    render :new
  end
  
  def create
    @post = Post.new(post_params)
    @post.author = current_user
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
  end

  def show
  end

  def destroy
  end

  private 
  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
end
