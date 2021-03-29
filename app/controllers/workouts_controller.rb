class WorkoutsController < ApplicationController
      before_action :set_user, only: [:bodypart_menu, :traning_lists, :index_menu_modal, :traning_day_contents]
  before_action :logged_in_user, only: [:index, :new, :create, :edit, :update, :destroy, :bodypart_select,
                                        :traning_lists, :index_menu_modal, :traning_day_contents]
  before_action :user_id_set, only: [:new, :show, :index, :create, :edit, :destroy, :update]
  before_action :work_day, only: [:new, :index, :edit]
  before_action :day_id_set, only: [:index, :create, :edit, :update, :destroy]
  
  def index
    @workouts = @day.workouts.where(user_id: params[:user_id])
    
  end
  
  def new
    @users = User.all
    @workout = Workout.new(user_id: params[:user_id], day_id: params[:day_id], body_part: params[:body_part])
    @traning_menus = @user.traning_menus.where(body_part: params[:body_part])
  end
  
  def create
    @workout = @day.workouts.new(workout_params)
    if @workout.save
      flash[:success] = "新規作成しました。"
      redirect_to user_day_workouts_url(@user, day_id: params[:day_id], body_part: params[:body_part])
    else
      flash[:danger] = "新規作成に失敗しました。"
      redirect_to user_day_workouts_url(@user, day_id: params[:day_id], body_part: params[:body_part])
    end
  end
  
  def edit
    @workout = @day.workouts.find(params[:id])
  end
  
  def update
    @workout = @day.workouts.find(params[:id])
    if @workout.update_attributes(workout_params)
      flash[:success] = "更新しました。"
      redirect_to user_day_workouts_url(@user, day_id: params[:day_id], body_part: params[:body_part])
    else
      render :edit      
    end
  end
  
  def destroy
    @workout = @day.workouts.find(params[:id])
    @workout.destroy
    flash[:success] = "削除しました。"
    redirect_to user_day_workouts_url @user
  end
  
  def traning_lists
    @first_day = params[:date].nil? ?
    Date.current.beginning_of_month : params[:date].to_date
    @last_day = @first_day.end_of_month
    
    @days = @user.days.where( worked_on: @first_day..@last_day).order(:worked_on)
    
    @workout = TraningMenu.find_by(traning_event: params[:traning_event])
    
    
    #days = @days.pluck(:worked_on)
    
    #books = days.map{ |day| Workout.where(worked_on: day)
    
    #@graph = LazyHighCharts::HighChart.new('graph') do |f|
    #  f.title(text: '本 月間登録推移')
    #  f.xAxis(categories: days)
    #  f.series(name: '登録数', data: books)
    #  f.series(name: '登録数', data: books)
    #end
  end
  
  def index_menu_modal
    @workout = Workout.find_by(traning_event: params[:traning_event])
  end
  
  def traning_day_contents
    @first_day = params[:date].nil? ?
    Date.current.beginning_of_month : params[:date].to_date
    @last_day = @first_day.end_of_month
    
    @days = @user.days.where( worked_on: @first_day..@last_day).order(:worked_on)
    
    @workout = TraningMenu.find_by(traning_event: params[:traning_event])
    
    @day = Day.find(params[:day_id])
    
    
    #books = days.each { |item| Workout.where(traning_kg: item) }
    
    #@graph = LazyHighCharts::HighChart.new('graph') do |f|
    #  f.title(text: '本 月間登録推移')
    #  f.xAxis(categories: days)
    #  f.series(name: '登録数', data: books)
    #  f.series(name: '登録数', data: books)
    #end
  end
  
  def bodypart_select
    @bodyparts = Bodypart.all
  end
  
  private
    
    def workout_params
      params.require(:workout).permit(:worked_on, :body_part, :traning_event, :target_muscle, :traning_set, :traning_kg, :traning_rep, :note)
    end
  
end
