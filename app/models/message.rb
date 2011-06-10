class Message
  include Mongoid::Document
  include Mongoid::Timestamps
  field :body
  field :markdown
  embedded_in :user, :inverse_of => :messages
end
