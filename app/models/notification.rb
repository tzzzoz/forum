class Notification
    include Mongoid::Document
    include Mongoid::Timestamps

    embedded_in :user, :inverse_of => :notifications

    field :person_id
    field :person_name
    field :did
    field :model
    field :instance_id
    field :excerpt

    # read status, false means unread
    field :status, :type => Boolean, :default => false


    def self.write(me, friend, method, m0del, markdown)
        if me.id != friend.id
            flag = true
            me.notifications.each do |notification|
                if notification.instance_id == m0del.id
                    flag = false
                    break
                end
            end
            if flag
                if method == "answered"
                    desc = "note_answered"
                elsif method == "commented"
                    desc = "note_replied"
                elsif method == "accepted"
                    desc = "note_accepted"
                end
                me.notifications.create(
                :person_id => friend.id,
                :person_name => friend.name,
                :did => desc,
                :model => m0del.class.to_s,
                :instance_id => m0del.id,
                :excerpt => markdown.gsub(/<\/?[^>]*>/,  "")
                )
            end
        end
    end

end
