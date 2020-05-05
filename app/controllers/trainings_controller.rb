class TrainingsController < ApplicationController
  def index
    @category = Category.find(params[:id])
    @trainings = @category.training.all
  end

  def show
  end

  def new
    # @category = Category.find(training[:category_id])
    @category = Category.find(params[:category_id])
    # @category_id = @category.id
    @training = Training.new
  end

  def create
    # @training = @category.trainings.build
    
    @training = Training.new(training_params)
    @category = Category.find(params[:category_id])
    @training.category_id = @category.id
    # @category = @training.category.find(params[:id])
    # @training.category_id = @category.id
    if @training.save
      flash[:success] = "登録完了"
      redirect_to @category
    else
      flash[:danger] = "登録失敗"
      render :show
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  
  private
  
  def training_params
    params.require(:training).permit(:content, :time, :date)
  end
  
end
