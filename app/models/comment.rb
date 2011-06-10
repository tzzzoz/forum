class Comment
    include Mongoid::Document
    include Mongoid::Timestamps
    field :body
    field :markdown
    validates_presence_of :body
    referenced_in :user, :inverse_of => :comments
    embedded_in :answer, :inverse_of => :comments
    embedded_in :question, :inverse_of => :comments
end
