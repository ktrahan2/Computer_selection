class Computer < ActiveRecord::Base
    has_many :recommendations
    has_many :customers, through: :recommendations

   

    
end