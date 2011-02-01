class TopicsController < ApplicationController

  respond_to :html
  before_filter :find_topic, :except => [ :index, :new, :create ]

  def create
    @topic = Topic.new(params[:topic])
    if @topic.save
      redirect_to topics_path, :notice => 'Topic was successfully created.'
    else
      render :action => "new"
    end
  end

  def destroy
    @topic.destroy
    redirect_to topics_path, :notice => "#{@topic.title} was deleted"
  end

  def edit
  end

  def index
    @topics = Topic.all
    respond_with @topics
  end

  def new
    @topic = Topic.new
  end

  def show
    @comment = Comment.new
  
    respond_with @topic
  end

  def update
    @topic.update_attributes(params[:topic])  
    if @topic.save
      redirect_to topics_path
    else
      render :action => 'edit'
    end
  end

  private
  
  def find_topic
    @topic = Topic.find_by_id(params[:id])
  end

end
