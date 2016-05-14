class Admin::SizesController < Admin::BaseController

  before_action :find_size, only: [:show, :edit, :update, :destroy]

  def index
    @sizes = Size.all
  end

  def new
    @size = Size.new
  end

  def show; end

  def edit; end

  def update
    if @size.update_attributes size_params
      redirect_to admin_size_path(@size)
      flash[:success] = t 'flash.size.success.updated'
    else
      flash[:error] = @size.errors.full_messages.join('<br/>').html_safe
      render :edit
    end
  end

  def create
    @size = Size.new size_params

    if @size.save
      redirect_to admin_size_path(@size)
      flash[:success] = t 'flash.size.success.created'
    else
      flash[:error] = @size.errors.full_messages.join('<br/>').html_safe
      render :new

    end
  end

  def destroy
    if @size.destroy
      redirect_to admin_sizes_path
      flash[:success] =  t 'flash.size.success.deleted'
    else
      flash[:destroy] = t 'flash.size.fail.deleted'
    end
  end

  def size_params
    params[:size].permit!
  end

  def find_size
    @size = Size.find params[:id]
  end

end
