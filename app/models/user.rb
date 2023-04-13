class User < ApplicationRecord
    has_secure_password
    has_many :wagers, dependent: :destroy
    has_many :games, through: :wagers

    validates :email, presence: true, uniqueness: true
    # validates :age, numericality: { greater_than_or_equal_to: 18 }
end
