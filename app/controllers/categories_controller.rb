class CategoriesController < ApplicationController
  
  # require date
  # day = DateTime.now
  # str = day.strftime("%Y-%m-%d %H:%M:%S")
  # post_day
  
  def index
    @categories = Category.all
    # @category = Category.find(params[:id])
  end
  
  def show
    @category = Category.find(params[:id])
    
    
    # @trainings = @category.trainings.where(created_at: Date.today.all_day)
    t = Time.now
    tt = t.strftime("%H%M%S")
    ttt = tt.to_i
    if ttt > 150000 && ttt < 235959
      @trainings = @category.trainings.where("created_at between '#{Date.today} 15:00:00' and '#{Date.tomorrow} 14:59:59'")
    elsif ttt < 145959
      @trainings = @category.trainings.where("created_at between '#{Date.yesterday} 15:00:00' and '#{Date.today} 14:59:59'")
    end
    
    n = ttt + 90000
    if n >= 240000
      @training_day = Date.tomorrow
    else
      @training_day = Date.today
    end
    
    
    # @training = @category.trainings.build
    # if @training.save
    #   flash[:success] = "登録完了"
    #   redirect_to category
    # else
    #   flash[:danger] = "登録失敗"
    #   render :show
    # end
    
    # @category = Category.find(params[:category_id])
    @training = Training.new
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
