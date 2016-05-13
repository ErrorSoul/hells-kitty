class Admin::SizesController < Admin::BaseController

  def index
    @sizes = Size.all
  end

  def new
    @size = Size.new
    flash[:success] = t 'flash.size.success.created'
  end

  def show
    @size = Size.find params[:id]
  end

  def edit
    @size = Size.find params[:id]
  end

  def update
    @size = Size.find params[:id]

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

  def size_params
    params[:size].permit!
  end

end
