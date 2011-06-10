class TopicsController < ApplicationController
    
    set_tab :topics
            
    autocomplete :topic, :name, :full => true
    
    def create
        @topic = Topic.find_or_create_by(:name => params[:topic])
        current_user.topics << @topic
    end
    
    def update
        @topic = Topic.find(params[:id])
        @topic.update_attributes(params[:topic])
    end
    
    def neighborhood
        @topic = Topic.find_or_create_by(:name => params[:neighborhood])
        current_user.topics << @topic
        neighborhood = Topic.find(params[:neighbor])
        neighborhood.neighbors << @topic
    end
    
    def add
        @topic = Topic.find(params[:id])
        current_user.topics << @topic
    end
    
    def destroy
        @topic = Topic.find(params[:id])
        @topic.remove_user(current_user)
    end
    
    def index
    end
    
    def show
        @node = Topic.find(params[:id])
        @nav = Topic.find(request.request_uri.gsub('/topics/',''))
    end
end
