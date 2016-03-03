ActiveRecord::Base.establish_connection(
  ENV['DATABASE_URL']||'sqlite3:db/development.db')

class Contribution < ActiveRecord::Base

  belongs_to :user
  has_many :goods
  
  validates :item_name,
      presence: true
  
end

class User < ActiveRecord::Base
  
  has_many :contributions
  has_many :goods
    
  has_secure_password
  VALID_EMAIL_REGEX =  /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    
    validates :username,
        length: {in: 1..15},
        presence: true,
        uniqueness: true
    
    validates :email,
        format: { with: VALID_EMAIL_REGEX },
        presence: true,
        uniqueness: true
end

class Good < ActiveRecord::Base
  
  belongs_to :contribution
  belongs_to :user
  
end

class Want < ActiveRecord::Base
  
  belongs_to :contribution
  belongs_to :user
  
end