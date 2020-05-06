class CategoriesController < ApplicationController
  
  def index
     @categories = Category.all
  end
  
  def show
    @category = Category.find(params[:id])
    @training = Training.new
    
    
    # @category_a = Category.find(params[:id])
    @search = @category.trainings.ransack(params[:q])

    @search_trainings = 
      # if params[:q].blank?
      #   Training.none.search
      # else  
        @search.result(distinct: true)
      # end
    
    
    

    # --------当日の投稿内容表示--------
    @trainings = @category.trainings.where(created_at: Time.current.all_day)
    # ----------------------------------

    #--------「xx年xx月xx日」の計算--------
    # t = Time.now.strftime("%H%M%S").to_i + 90000
    # if t >= 240000
      @training_day = Date.current
    # else
    #   @training_day = Date.today
    # end
    #--------------------------------------
    
    # --------本日の合計時間--------
    @today_total = 0
    @trainings.each do |train|
      s = train.time
      @today_total += s
    end
    @today_total
    # ------------------------------
    
    # --------トータルの合計時間--------
    @total_trainings = @category.trainings.all
    @all_total = 0
    @total_trainings.each do |total_train|
      u = total_train.time
      @all_total += u
    end
    @all_total
    # ----------------------------------
    
    # --------今月の合計時間--------
    @month_trainings = @category.trainings.where(created_at: Time.current.all_month)
    @month_total = 0
    @month_trainings.each do |month_train|
      v = month_train.time
      @month_total += v
    end
    @month_total
    # ------------------------------
    # @ttraining = Training.find(params[:id])
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
      flash[:success] = "カテゴリを登録しました。"
      redirect_to root_url
    else
      flash[:danger] = "カテゴリ登録に失敗しました。"
      render :new
    end
  end
  
  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:success] = "カテゴリを変更しました。"
      redirect_to @category
    else
      flash[:danger] = "カテゴリの変更に失敗しました。"
      render :edit
    end
  end
  
  def destroy
    @category = Category.find(params[:id])
    @category.delete
    flash[:success] = "カテゴリを削除しました。"
    redirect_to root_url
  end
  
  
  private
  
  def category_params
    params.require(:category).permit(:name)
  end
  
  # def training_params
  #   params.permit(:content, :time, :date)
  # end
  
end
