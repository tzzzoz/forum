# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

print "Deleting all users..."
User.delete_all
puts "[OK]"

print "Creating some users..."
User.create(:name => "greedy", :email => "greedy@gmail.com", :password => "greedy", :password_confirmation => "greedy", :roles_mask => 5)
User.create(:name => "tzzzoz", :email => "tzzzoz@gmail.com", :password => "tzzzoz", :password_confirmation => "tzzzoz")
User.create(:name => "vvdpzz", :email => "vvdpzz@gmail.com", :password => "vvdpzz", :password_confirmation => "vvdpzz")
User.create(:name => "zoe", :email => "nankezi.lvqing@gmail.com", :password => "zoezoe", :password_confirmation => "zoezoe")
puts "[OK]"

print "Deleting all topics..."
Topic.delete_all
puts '[OK]'

print "Creating some topics..."
taglist = ["C++", "C", "Windows 7", "Ajax", "CSS", "PostgreSQL", "Kinect", "Google App Engine", "Steve Jobs", "MacBook Air", "IPS", "iPod", "iWork", "iLife", "iPod classic", "iPod nano", "iPod shuffle", "iPod touch", "Mac OS X", "Bill Gates", "iPod touch 4", "iPhone 4", "C#", "Thin", "Nginx", "Unicorn", "Passenger", "Ruby Enterprise Edition", "Ruby", "Microsoft", "Google", "Android", "MacBook Pro", "Lisp", "Ubuntu", "Debian", "Python", "Django", "MySQL", "MongoDB", "Mongoid", "iOS", "Java", "iPhone 3G", "iPhone 3GS", "Retina", "Snow Leopard", "Leopard", "Lion", "Apple", "iPhone", "Xbox", "A4 chip", ".Net", "Kik Messenger", "Instagram", "JSP", "Apache", "Nexus One", "Nexus S", "iPad", "Heroku", "Sync", "Ruby on Rails", "Grails", "Social Networking", "AMOLED", "App Store", "Tomcat"]
taglist.each do |tag|
    topic = Topic.find_or_create_by(:name => tag)
end
puts '[OK]'


# print "Delete all topics..."
# Topic.delete_all
# puts "[OK]"
# print "Build Topics tree..."
# open("/Users/vvdpzz/Desktop/AmazingTree.txt") do |fin|
# open("/Users/vvdpzz/Desktop/AmazingTree.txt") do |fin|
# current_user = User.first
# open("/Users/vvdpzz/Desktop/topics.txt") do |fin|
#     while !fin.eof?
#         topic = Topic.find_or_create_by(:name => fin.readline.chomp)
#         current_user.topics << topic
#     end
# end
#   while !fin.eof?
#     list = []
#     line = fin.readline.chomp
#     if line == "--------------------------"
#       topic = fin.readline.chomp
#       each = fin.readline.chomp
#       while each != "++++++++++++++++++++++++++" and !fin.eof?
#         list << each
#         each = fin.readline.chomp
#       end
#       puts topic
#       if list.empty?
#         Topic.find_or_create_by(:name => topic)
#       else
#         i = 0
#         while i < list.size
#           p = i
#           c = p + 1
#           parent = Topic.find_or_create_by(:name => list[p])
#           child = Topic.find_or_create_by(:name => list[c])
#           parent.children << child
#           if list[c] == topic
#             i += 2
#           else
#             i += 1
#           end
#         end
#       end
#     end
#   end
# end
# puts "[OK]"
