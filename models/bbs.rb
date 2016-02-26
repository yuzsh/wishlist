ActiveRecord::Base.establish_connection(
  ENV['DATABASE_URL']||'sqlite3:db/development.db')

class Contribution < ActiveRecord::Base
end

class User < ActiveRecord::Base
    has_secure_password
    validates :username, format: {with: /¥w*/}
    validates :username, length: {in: 1..15}
    validates :username, presence: true
end
