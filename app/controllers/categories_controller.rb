class CategoriesController < ApplicationController
  
  def index
    @categories = Category.all
    # @category = Category.find(params[:id])
  end
  
  def show
    @category = Category.find(params[:id])
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
  
  
  
end
