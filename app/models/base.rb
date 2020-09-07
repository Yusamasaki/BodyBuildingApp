class Base < ApplicationRecord
  validates :basenumber, presence: true, uniqueness: true
  validates :basename, presence: true
  validates :baseinfo, presence: true
end
