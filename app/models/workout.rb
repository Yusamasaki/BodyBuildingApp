class Workout < ApplicationRecord
  belongs_to :day
  has_many :traning_menus
  
  validates :traning_event, presence: true
  validates :target_muscle, presence: true
  validates :traning_set, presence: true
  validates :traning_kg, presence: true
  validates :traning_rep, presence: true
  
end
