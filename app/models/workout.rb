class Workout < ApplicationRecord
  belongs_to :day
  has_many :traning_menus
end
