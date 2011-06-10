class UnansweredController < ApplicationController
    set_tab :unanswered
    
    def index
        @questions = Question.any_in(:answer_stats => ["unanswered", "answered"])
    end
end
