class Admin::ProductsController < Admin::BaseController

  def index
    @products = Product.includes(:product_attachments).all
  end

  def new
    @product = Product.new
    @product_attachment = @product.product_attachments.build
  end

  def create
    @product = Product.new product_params
    if @product.save
      params[:product_attachments]['asset'].each do |a|
        @product.product_attachments.create!(asset: a)
      end
      flash[:success] = t('flash.product.success.created')
      redirect_to admin_product_path(@product)
    else
      flash[:error] = @product.errors.full_messages.join('<br/>').html_safe
      render :new
    end
  end

  def show
    @product = Product.includes(:product_attachments, :category).find params[:id]

  end

  def edit
    @product = Product.includes(:product_attachments).find params[:id]
    diff = 5 - @product.product_attachments.size
    diff.times { @product.product_attachments.build } if diff > 0
  end

  def update
     @product = Product.find params[:id]
    if @product.update_attributes product_params
      flash[:success] = t('flash.product.success.updated')
      redirect_to admin_product_path(@product)
    else
      flash[:error] = @product.errors.full_messages.join('<br/>').html_safe
      render :edit
    end
  end

  private

  def product_params
    params.require(:product).permit(
      :name, :price, :marking, :category_id,
      product_attachments_attributes: [:id, :product_id, :asset, :_destroy],
      product_sizes_attributes: [:id, :product_id, :size_id, :value]
    )
  end
end
