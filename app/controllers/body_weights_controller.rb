class BodyWeightsController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
  before_action :user_id_set, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :body_weight_day, only: [:index]
  
  def index
    @dayline = Array.new
    @days.each do |day|
      @dayline.push(day.worked_on.strftime('%m/%d').to_s)
    end
    
    @days.each do |day|
      @body_weights = @user.body_weights.where(worked_on: @first_day..@last_day)
      @line = Array.new
      @body_weights.each do |body_weight|
        @line.push(body_weight.weight)
      end
    end
  end

  def new
    @body_weight = @user.body_weights.find(params[:id])
  end
  
  def create
    @body_weight = @user.body_weights.new(body_weight_params)
    if @body_weight.save
      flash[:success] = "新規追加しました。"
      redirect_to user_body_weights_url(@user, worked_on: params[:worked_on])
    else
      flash[:danger] = "追加に失敗しました。"
      redirect_to user_body_weights_url(@user, worked_on: params[:worked_on])
    end
  end
  
  def edit
    @body_weight = @user.body_weights.find_by(worked_on: params[:worked_on])
  end
  
  def update
    @body_weight = @user.body_weights.find_by(worked_on: params[:worked_on])
    if @body_weight.update_attributes(body_weight_params)
      flash[:success] = "更新しました。"
      redirect_to user_body_weights_url(@user, date: params[:date])
    else
      render :edit      
    end
  end
  
  def show
  end
  
  
  def destroy
  end
  
  private
    
    def body_weight_params
      params.require(:body_weight).permit(:weight, :worked_on)
    end
  
end
