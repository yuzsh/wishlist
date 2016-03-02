ActiveRecord::Base.establish_connection(
  ENV['DATABASE_URL']||'sqlite3:db/development.db')

class Contribution < ActiveRecord::Base
  has_reputation :likes, source: :user, aggregated_by: :sum
  # 追加
  belongs_to :user
  
  validates :item_name,
      presence: true
  
end

class User < ActiveRecord::Base
  
  has_many :contributions
    
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
