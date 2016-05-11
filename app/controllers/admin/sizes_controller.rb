class Admin::SizesController < Admin::BaseController

  def index
    @sizes = Size.all
  end

  def new
    @size = Size.new
  end

  def show
  end

  def create
    @size = Size.new size_params

    if @size.save
      redirect_to admin_sizes_path
      flash[:success] = t 'flash.size.success.created'
    else
      render :new
      flash[:error] = @size.errors.full_messages.join('<br/>').html_safe
    end
  end

  def size_params
    params[:size].permit!
  end

end
