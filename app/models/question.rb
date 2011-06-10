class Question

    include Mongoid::Document
    include Mongoid::Timestamps

    # description of question, long is optional
    field :short
    validates_length_of :short, :within => 15..140, :on => :create, :message => "must be within 15..140 words"
    field :long

    # markdown
    field :markdown4short
    field :markdown4long
    
    # excerpt
    field :excerpt

    # topic list
    field :topic_list
        validate :topics_count_must_within_one_to_five
    
    validate :must_could_afford, :on => :create

    # Money
    field :bucket, :type => Integer, :default => 0
    field :reward, :type => Integer, :default => 0
        validates_numericality_of :reward
    field :sum, :type => Integer, :default => 0
    field :max, :type => Integer, :default => 0

    # Viewed Times
    field :viewed, :type => Integer, :default => 0

    # Anonymous Question
    field :anonymous, :type => Boolean, :default => false

    # Accepted Answer id
    field :accepted_answer
    
    # unanswered, answered, accepted
    field :answer_stats, :default => "unanswered"

    embeds_many :comments

    referenced_in :user, :inverse_of => :questions
    references_and_referenced_in_many :topics, :inverse_of => :questions
    references_many :answers

    def markdown_for_short_and_long
        self.markdown4short = BlueCloth.new(self.short).to_html
        self.markdown4long  = BlueCloth.new(self.long).to_html
        self.excerpt = truncate(self.markdown4short.gsub(/<\/?[^>]*>/,  ""), :length => 140)
    end

    def parse_topic_list
        taglist = ActsAsTaggableOn::TagList.from self.topic_list
        self.topic_list = taglist.to_s
    end
    
    def add_topics
        taglist = ActsAsTaggableOn::TagList.from self.topic_list
        taglist.each do |tag|
            topic = Topic.find_or_create_by(:name => tag)
            self.topics << topic
            self.user.topics << topic
        end
    end
    
    def add_topics_to(user)
        self.topics.each do |topic|
            user.topics << topic
        end
    end
    
    def charge(ask = APP_CONFIG['ask_fee'].to_i, reward = self.reward)
        sum = ask + reward
        user_out sum
        calc_sum_and_update_max
    end

    def user_out(amount)
        # user = User.find self.user.id
        user.update_attribute(:money, self.user.money - amount)
    end
    
    def calc_sum_and_update_max
        current_sum = self.bucket + self.reward
        if self.sum != current_sum
            self.update_attribute(:sum, current_sum)
            if self.sum > self.max
                self.update_attribute(:max, current_sum)
            end
        end
    end

    def accounting_for_ask
        fee = APP_CONFIG['ask_fee'].to_i
        self.user.records.create!(
        :sn          => Time.stamp,
        :io          => "out",
        :reason      => "ask",
        :description => truncate(self.excerpt),
        :amount      => fee,
        :model       => self.class.to_s,
        :instance_id => self.id,
        :status      => "success"
        )
        user = User.find_by_name("greedy")
        user.update_attributes(:money => user.money + fee)
        
        user.records.create!(
        :sn          => Time.stamp,
        :io          => "in",
        :reason      => "ask",
        :description => truncate(self.excerpt),
        :amount      => fee,
        :model       => self.class.to_s,
        :instance_id => self.id,
        :status      => "success"
        )
    end

    def accounting_for_reward(fee = self.reward)
        self.user.records.create!(
        :sn          => Time.stamp,
        :io          => "out",
        :reason      => "reward",
        :description => truncate(self.excerpt),
        :amount      => fee,
        :model       => self.class.to_s,
        :instance_id => self.id,
        :status      => "pending"
        )
    end

    
    def accounting_for_destroy_question(fee)
        self.user.records.create!(
            :sn => Time.stamp,
            :io => "in",
            :reason => "delete_q",
            :description => "问题被删除",
            :amount => fee,
            :model => self.class.to_s,
            :status => "success"
        )
    end
    
    def truncate(text, options = {})
        options.reverse_merge!(:length => 30)
        text.truncate(options.delete(:length), options) if text
    end
    
    def topics_count_must_within_one_to_five
        list = ActsAsTaggableOn::TagList.from self.topic_list
        if list.count > 5
            errors.add(:topic_list, "can not be more than 5 tags")
        elsif list.count == 0
            errors.add(:tag_list, "must have 1 tag at least")
        end
    end
    
    def must_could_afford
        if self.user.money < self.reward + APP_CONFIG['ask_fee'].to_i
            errors.add(:reward, "you do not have enough money to pay, please recharge.")
        end
    end

end
