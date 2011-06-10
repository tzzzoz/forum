class Feedback
  include Mongoid::Document
  include Mongoid::Timestamps
  field :excerpt
  field :body, :type => String
  
  embeds_many :comments
  
  referenced_in :user, :inverse_of => :feedbacks
  
  # Anonymous Question
  field :anonymous, :type => Boolean, :default => false
  
  def excerpt_short_markdown
      excerpt = truncate(self.body.gsub(/<\/?[^>]*>/,  ""), :length => 30)
      self.update_attributes(:excerpt => excerpt)
  end
  
  def truncate(text, options = {})
      options.reverse_merge!(:length => 30)
      text.truncate(options.delete(:length), options) if text
  end
end
