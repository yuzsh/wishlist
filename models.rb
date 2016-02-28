ActiveRecord::Base.establish_connection(
  ENV['DATABASE_URL']||'sqlite3:db/development.db')

class Contribution < ActiveRecord::Base
end

class User < ActiveRecord::Base
    has_secure_password
    # validates :username, 
    #     format: {with: /¥w*/},
    #     length: {in: 1..15},
    #     presence: true
    # validates :email, 
    #     format: {with: /.+@.+/},
    #     presence: true
    # validates :password, 
    #     length: {in: 1..10},
    #     presence: true
end