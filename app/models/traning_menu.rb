class TraningMenu < ApplicationRecord
    belongs_to :user
    
    validates :traning_event, presence: true, uniqueness: true
    
    
end
