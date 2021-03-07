class DaysController < ApplicationController
      
  before_action :work_set, only: [:index]
  before_action :work_day, only: [:index]
  
  def index
    
  end
  
end
