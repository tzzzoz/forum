class QuestionsController < ApplicationController
    
    set_tab :questions
    set_tab :ask, :only => %w(new)

    def new
        @question = current_user.questions.build
    end

    def create
        @question = current_user.questions.build(params[:question])
        @question.markdown_for_short_and_long
        @question.parse_topic_list

        if @question.save
            @question.add_topics
            @question.charge
            @question.accounting_for_ask
            @question.accounting_for_reward
            redirect_to(@question, :notice => 'Question was successfully created.')
        else
            render :new
        end
    end
    
    def update
        @question = Question.find params[:id]
        new_reward = params[:question][:reward].to_i
        offset = new_reward - @question.reward
        if offset > 0
            @question.charge(reward = offset)
            @question.accounting_for_reward(fee = offset)
        else
            params[:question][:reward] = @question.reward
        end
        
        if @question.update_attributes(params[:question])
            @question.markdown_for_short_and_long
            @question.parse_topic_list
            if @question.save
                @question.add_topics
                redirect_to @question
            end
        else
            render :edit
        end
    end

    def index
        @questions = Question.all
    end
    
    def show
        @question = Question.find params[:id]
        current_user.notifications.each do |notification|
            if notification.instance_id == @question.id
                notification.destroy
            end
        end
    end
    
    def edit
        @question = Question.find params[:id]
    end

    def asked
        @questions = current_user.questions
    end
    def answered
        @questions = []
        answers = Answer.where(:user_id => current_user.id)
        answers.each {|answer| @questions << answer.question}
    end
    def accepted
        @answer = Answer.find(params[:id])
        if current_user.id == @answer.question.user.id and @answer.question.accepted_answer == nil
            @answer.question.accepted_answer = @answer.id
            
            fee = @answer.question.bucket + @answer.question.reward
            @answer.question.bucket = 0
            @answer.question.reward = 0
            @answer.question.answer_stats = "accepted"
            
            if @answer.question.save
                @answer.user.money += fee
                @answer.user.save
                @answer.accounting_for_accept(fee)
                
                redirect_to @answer.question
                rewardrecords = @answer.question.user.records.where(:reason => "reward", :instance_id => @answer.question.id)
                rewardrecords.each do |rewardrecord|
                    rewardrecord.status = "success"
                    rewardrecord.save
                end
                Notification.write(me = @answer.user, friend = current_user, method = "accepted", m0del = @answer.question, markdown = @answer.question.excerpt)
            end
        end
    end
    
    def tagged_questions
        @topic = Topic.find(params[:id])
        @tagged_questions = @topic.questions
    end
end
