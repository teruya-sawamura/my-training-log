class TrainingsController < ApplicationController
  def index
    @category = Category.find(params[:id])
    @trainings = @category.training.all
  end

  def show
  end

  def new
    # @category = Category.find(params[:category_id])
    # @training = Training.new
  end

  def create
    @training = Training.new(training_params)
    @category = Category.find(params[:category_id])
    @training.category_id = @category.id
    if @training.save
      flash[:success] = "登録完了"
      redirect_to @category
    else
      flash[:danger] = "登録失敗"
      redirect_to @category
    end
  end

  def edit
    @category = Category.find(params[:category_id])
    @training = @category.trainings.find(params[:id])
  end

  def update
    @category = Category.find(params[:category_id])
    @training = @category.trainings.find(params[:id])
    if @training.update(training_params)
      flash[:success] = "内容を変更しました。"
      redirect_to @category
    else
      flash[:danger] = "変更に失敗しました。"
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:category_id])
    @training = @category.trainings.find(params[:id])
    @training.delete
    flash[:success] = "削除しました。"
    redirect_to @category
  end
  
  
  private
  
  def training_params
    params.require(:training).permit(:content, :time, :date)
  end
  
end
