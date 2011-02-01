class CommentsController < ApplicationController

  respond_to :html
  before_filter :find_comment, :except => [ :index, :new, :create ]

  def create
    @comment = Comment.new(params[:comment])
    if @comment.save
      redirect_to @comment.commentable_root, :notice => 'Comment was successfully created.'
    else
      render :action => "new"
    end
  end

  def destroy
    @comment.destroy
    redirect_to @comment.commentable_root, :notice => "Comment was deleted"
  end

  def edit
  end

  def index
    @comments = Comment.all
    respond_with @comments
  end

  def new
    @comment = Comment.new(:commentable_id => params[:id], :commentable_type => params[:commentable_type])
  end

  def show
    respond_with @comment
  end

  def update
    if @comment.update_attributes(params[:comment])
      redirect_to @comment.commentable_root, :notice => 'Comment was successfully updated.'
    else
      render :action => 'edit'
    end
  end
  
  private

  def find_comment
    @comment = Comment.find_by_id(params[:id])
  end

end
