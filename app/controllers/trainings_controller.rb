class TrainingsController < ApplicationController
  def index
    @category = Category.find(params[:category_id])
    @search = @category.trainings.ransack(params[:q])

    @search_trainings = 
      if params[:q].blank?
        Training.none.search
      else  
        @search.result(distinct: true)
      end
  end

  def show
    @category = Category.find(params[:category_id])
    @training = @category.trainings.find(params[:id])
  end

  def create
    @training = Training.new(training_params)
    @category = Category.find(params[:category_id])
    @training.category_id = @category.id
    if @training.save
      flash[:success] = "Entry new training!"
      redirect_to @category
    else
      flash[:danger] = "Failed..."
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
      flash[:success] = "Edit training!"
      redirect_to @category
    else
      flash[:danger] = "Failed..."
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:category_id])
    @training = @category.trainings.find(params[:id])
    @training.delete
    flash[:success] = "Delete training!"
    redirect_to @category
  end
  
  
  private
  
  def training_params
    params.require(:training).permit(:content, :time, :date)
  end
  
end
