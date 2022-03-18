class SubsController < ApplicationController
  
  def index
    @subs = Sub.all
    render :index
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator = current_user
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = current_user.subs.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit 
    end
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def destroy
    @sub = current_user.subs.find(params[:id])
    if @sub
      @sub.destroy
    end
    redirect_to subs_url
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end

end
