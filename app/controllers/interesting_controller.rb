class InterestingController < ApplicationController
    set_tab :interesting
    
    def index
        @questions = []
        current_user.topics.each do |topic|
            @questions = @questions.concat topic.questions.any_in(:answer_stats => ["unanswered", "answered"])
        end
        @questions.uniq!
    end
end
