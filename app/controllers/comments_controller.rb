class CommentsController < ApplicationController
    before_filter :who_called_comment
    def new
        @comment = @m0del.comments.build
    end
    def create
        @comment = @m0del.comments.create(:user_id => current_user.id, :body => params[:comment][:body])
        if @comment.question.class.to_s == "Question"
            question = @comment.question
            Notification.write(me = question.user, friend = current_user, method = "commented", m0del = question, markdown = question.excerpt)
        elsif @comment.question.class.to_s == "Answer"
            answer = @comment.answer
            question = @comment.answer.question
            Notification.write(me = answer.user, friend = current_user, method = "commented", m0del = question, markdown = question.excerpt)
        elsif @comment.question.class.to_s == "Feedback"
            feedback = @comment.feedback
            Notification.write(me = feedback.user, friend = current_user, method = "commented", m0del = feedback, markdown = question.excerpt)
        end
    end
    
    protected
        def who_called_comment
            if params[:question_id]
                @name = "question"
                id = params[:question_id]
            elsif params[:answer_id]
                @name = "answer"
                id = params[:answer_id]
            elsif params[:feedback_id]
                @name = "feedback"
                id = params[:feedback_id]
            end
            @man = @name.classify.constantize
            @m0del = @man.find id
            return @m0del
        end
end
