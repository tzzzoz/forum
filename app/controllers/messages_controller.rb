class MessagesController < ApplicationController
    
    set_tab :messages
    
    def new
        @message = current_user.messages.build
    end
    def create
        @message = current_user.messages.build(params[:message])
        @message.markdown = BlueCloth.new(@message.body).to_html
        @message.save
    end
    def edit
        @message = current_user.messages.find(params[:id])
    end
    def update
        @message = current_user.messages.find(params[:id])
        @message.update_attributes(params[:message])
            @message.markdown = BlueCloth.new(@message.body).to_html
            @message.save
    end
    def destroy
        @message = current_user.messages.find(params[:id])
        @message.destroy
    end
    def index
        @messages = current_user.messages        
    end
end
