class Recommendation < ActiveRecord::Base
    belongs_to :computer
    belongs_to :customer
end