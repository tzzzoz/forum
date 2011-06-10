class AnswersController < ApplicationController
    def create
        answer_fee = APP_CONFIG['answer_fee'].to_i
        question = Question.find(params[:question_id])
        if current_user.money >= answer_fee
            @answer = question.answers.build(:user => current_user, :body => params[:answer][:body])
            
            # markdown
            @answer.markdown = BlueCloth.new(@answer.body).to_html
            
            if @answer.save
                @answer.accounting_for_answer(answer_fee)
                
                @answer.question.add_topics_to(@answer.user)
                
                if question.answers.count == 1
                    question.update_attribute(:answer_stats, "answered")
                end
                Notification.write(me = @answer.question.user, friend = current_user, method = "answered", m0del = @answer.question, markdown = @answer.question.excerpt)
            end
        end
    end
end
