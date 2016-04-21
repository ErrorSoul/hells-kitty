class Admin::CategoriesController < Admin::BaseController
  before_action :find_category, only: [:update, :destroy]

  def index; end

   def update
    if @category.update_attributes category_params
      flash[:success] = t 'flash.category.success.updated'
      redirect_to admin_categories_url
    else
      render :edit
    end
  end

  def create
    @category= Category.new category_params
    if @category.save
      redirect_to admin_categories_path
      flash[:success] = t 'flash.category.success.created'
    else
      render :new
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t 'flash.category.success.destroyed'
    else
      flash[:warning] = t 'flash.category.failed.destroyed'
    end
    redirect_to admin_categories_path
  end

  private

  def category_params
    params[:category].permit!
  end

  def find_category
    @category = Category.find params[:id]
  end
end
