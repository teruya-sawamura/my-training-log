class CategoriesController < ApplicationController
  
  def index
     @categories = Category.all
  end
  
  def show
    @category = Category.find(params[:id])
    @training = Training.new
    
    # --------Ransack用アクション--------
    @search = @category.trainings.ransack(params[:q])
    @search_trainings = 
    @search.result(distinct: true)
    # -----------------------------------
    
    # --------当日の投稿内容表示--------
    @trainings = @category.trainings.where(date: Time.current.all_day)
    # ----------------------------------

    #--------「xx年xx月xx日」の計算--------
      @training_day = Date.current
    #--------------------------------------
    
    # --------本日の合計時間--------
    ss = 0
    @trainings.each do |train|
      s = train.time
      ss += s
    end
    @today_total_hour = ss / 60
    @today_total_min = ss % 60
    # ------------------------------
    
    # --------トータルの合計時間--------
    @total_trainings = @category.trainings.all
    uu = 0
    @total_trainings.each do |total_train|
      u = total_train.time
      uu += u
    end
    @all_total_hour = uu / 60
    @all_total_min = uu % 60
    # ----------------------------------
    
    # --------今月の合計時間--------
    @month_trainings = @category.trainings.where(created_at: Time.current.all_month)
    vv = 0
    @month_trainings.each do |month_train|
      v = month_train.time
      vv += v
    end
    @month_total_hour = vv / 60
    @month_total_min = vv % 60
    # ------------------------------
    
    @search_category = Category.find(params[:id])
    @search = @search_category.trainings.ransack(params[:q])
    @search_trainings = @search.result
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Create new category!"
      redirect_to root_url
    else
      flash[:danger] = "Failed..."
      render :new
    end
  end
  
  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:success] = "Edit category!"
      redirect_to @category
    else
      flash[:danger] = "Failed..."
      render :edit
    end
  end
  
  def destroy
    @category = Category.find(params[:id])
    @category.delete
    flash[:success] = "Delete category!"
    redirect_to root_url
  end
  
  
  private
  
  def category_params
    params.require(:category).permit(:name)
  end

end
