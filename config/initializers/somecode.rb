class Time
    def self.stamp
        time = Time.now.to_f.to_s.gsub('.','')
        time = time[1..-1]
        time += '0'*(14 - time.length)
        time += rand.to_s[2..3]
        return time
    end
end