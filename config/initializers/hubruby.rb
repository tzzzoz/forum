# module GitHub
#     class Repository < OpenStruct
#         def languages
#             @languages ||= GitHub.languages(self.owner, self.name)
#         end
#     end
#     module Finders
#         def user_by_email(email)
#             j = json("/user/email/#{email}", :user)
#             User.from_hash(j)
#         end
#         def languages(login, repository_name)
#             j = json("/repos/show/#{login}/#{repository_name}/languages", :languages)
#         end
#         def topics(login)
#             tags = []
#             user = GitHub.user(login)
#             repos = user.repositories.map(&:name)
#             repos.each do |repo|
#                 tags.concat GitHub.repository(login, repo).languages.keys
#             end
#             return tags.uniq
#         end
#         def topics_by_email(email)
#             tags = []
#             user = GitHub.user_by_email(email)
#             login = user.login
#             repos = user.repositories.map(&:name)
#             repos.each do |repo|
#                 tags.concat GitHub.repository(login, repo).languages.keys
#             end
#             return tags.uniq
#         end
#     end
# end