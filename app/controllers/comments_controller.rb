class CommentsController < ApplicationController
  
  def index
    @comments = current_user.comments
    # if params[:user_id] && @user = User.find_by_id(params[:user_id])
    #   @comments = User.find_by_id(params[:user_id]).comments
    # else
    #   @comments = Comment.order(:name)
    # end
    # respond_to do |format|
    #   format.html
    #   format.json {render json: @comments.tokens(params[:q]) }
    # end
  end

  def show
  end

  def new
    @user = User.find(params[:user_id])
    @comment = Comment.new
    authorize @comment
  end

  def create
    @comment = Comment.new(comment_params)
    authorize @comment
    @user = User.find(params[:user_id])
    @comment.user = @user
    @comment.save

    redirect_to user_path(@user)
    flash[:notice] = "Created new comment in category #{@comment.category.upcase}."
  end

  def edit
    @user = User.find(params[:user_id])
    @comment = Comment.find(params[:id])
    if current_user == nil
      redirect_to new_user_session_path
      flash[:notice] = "Log in to edit this comment"
    end
    authorize @comment
  end

  def update
    @user = User.find(params[:user_id])
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to user_path(@user)
      flash[:notice] = "Edited comment in category #{@comment.category.upcase}."
    else
      render :edit
    end
    authorize @comment
  end

  def destroy
    @user = User.find(params[:user_id])
    @comment = Comment.find(params[:id])
    authorize @comment
    
    @comment.destroy

    redirect_to user_path(@user)
    if @comment.category == ""
      flash[:notice] = "Deleted comment"
    else
      flash[:notice] = "Deleted comment in category #{@comment.category.upcase}."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:category, :content)
  end
end
