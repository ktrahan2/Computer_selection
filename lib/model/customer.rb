class Customer < ActiveRecord::Base
    has_many :recommendations
    has_many :computers, through: :recommendations
end