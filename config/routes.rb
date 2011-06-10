Dream::Application.routes.draw do
    
    resources :feedbacks

    match '/questions/asked' => "questions#asked", :as => :asked
    match '/questions/answered' => "questions#answered", :as => :answered
    match '/questions/accepted/:id' => "questions#accepted", :as => :accept_answer
    match '/interesting' => "interesting#index", :as => :interesting
    match '/unanswered' => "unanswered#index", :as => :unanswered
    resources :questions do
        resources :answers
        resources :comments
    end
    resources :answers do
        resources :comments
    end
    resources :feedbacks do
        resources :comments
    end
    
    match '/topics/neighborhood' => "topics#neighborhood", :via => "post"
    match '/topics/:id/add' => "topics#add", :as => :add, :via => "get"
    
    resources :topics do
        get :autocomplete_topic_name, :on => :collection
    end
    
    resources :messages
    
    match '/tagged/:id' => "questions#tagged_questions", :as => :tagged_questions
        
    devise_for :users
    resources :users do
       get :autocomplete_user_name, :on => :collection
    end

    match '/superusers/user' => "superusers#user", :as => :superusers_users
    match '/superusers' => "superusers#index", :as => :superusers_index
    match '/superusers/question' => "superusers#question", :as => :superusers_questions
    match '/superusers/question/:id' => "superusers#show", :as => :superusers_show
    match '/superusers/topic' => "superusers#topic", :as => :superusers_topic
    match '/superusers/neighbor' => "superusers#neighbor", :as => :superusers_neighbor
    match '/superusers/recharge' => "superusers#recharge", :as => :superusers_recharge
    match '/superusers/role_manage' => "superusers#role_manage", :as => :superusers_role_manage
    match '/superusers/destroy/:one_id/:another_id' => "superusers#destroy", :as => :superusers_destroy
    match '/superusers/destroy/:id' => "superusers#destroy_question", :as => :superusers_destroy_question
    
    root :to => "questions#index"
end
