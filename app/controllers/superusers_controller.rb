class SuperusersController < ApplicationController
        
    before_filter :auth
    
    def user
        @users = User.all
    end
    def question
        @questions = Question.all
    end
    def index
        
    end
    def show
        @question = Question.find(params[:id])
    end
    def topic
        @topics = Topic.all
    end
    def neighbor
        @topics = Topic.all
    end
    def recharge
        user = User.where(:name => params[:name]).first
        amount = params[:amount].to_i
        if user
            user.accounting_for_recharge(amount)            
        end
    end
    def role_manage
        user = User.where(:name => params[:name]).first
        roles = params[:roles]
        temp_roles = []
        if user && roles
            roles.each do |role|
                if role == '1'
                    temp_roles << :root
                end
                if role == '2'
                    temp_roles << :moderator
                end
                if role == '3'
                    temp_roles << :author
                end
            end
            user.roles = temp_roles
            user.save
        end
    end
    def destroy
        @one = Topic.find(params[:one_id])
        @another = Topic.find(params[:another_id])
        @one.remove_neighbor(@another)
    end
    
    def destroy_question
        @question = Question.find params[:id]
        answer_fee = APP_CONFIG['answer_fee'].to_i
        if current_user.roles.to_a & [:root]
            @question.user.money += @question.reward
            @question.user.save
            @question.accounting_for_destroy_question(@question.reward)
            
            @question.answers.each do |answer|
                answer.user.money += answer_fee
                answer.user.save
                answer.accounting_for_destroy_answer(answer_fee)
            end
            @question.answers.delete_all
            @question.destroy
        end
    end
    
    protected
        def auth
            if !(current_user.has_role? :root)
                redirect_to root_path
            end
        end
end
