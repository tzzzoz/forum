class FeedbacksController < ApplicationController
    
  def index
    @feedbacks = Feedback.all
  end

  def show
    @feedback = Feedback.find(params[:id])
    current_user.notifications.each do |notification|
        if notification.instance_id == @feedback.id
            notification.destroy
        end
    end
  end

  def new
    @feedback = current_user.feedbacks.build
  end

  def edit
    @feedback = Feedback.find(params[:id])
  end

  def create
    @feedback = current_user.feedbacks.build(params[:feedback])
    @feedback.excerpt_short_markdown
    @feedback.save
    
    redirect_to(feedbacks_path, :notice => 'Feedback was successfully created.')
  end

  def update
    @feedback = Feedback.find(params[:id])
    if @feedback.update_attributes(params[:feedback])
        @feedback.excerpt_short_markdown
        @feedback.save
        redirect_to @feedback
    else
        render :edit
    end
  end
  
end
