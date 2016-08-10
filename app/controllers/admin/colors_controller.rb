class Admin::ColorsController < Admin::BaseController

  before_action :find_color, only: [:show, :edit, :update, :destroy]

  def index
    @colors = Color.all
  end

  def new
    @color = Color.new
  end

  def show; end

  def edit; end

  def update
    if @color.update_attributes color_params
      redirect_to admin_color_path(@color)
      flash[:success] = t 'flash.color.success.updated'
    else
      flash[:error] = @color.errors.full_messages.join('<br/>').html_safe
      render :edit
    end
  end

  def create
    @color = Color.new color_params

    if @color.save
      redirect_to admin_color_path(@color)
      flash[:success] = t 'flash.color.success.created'
    else
      flash[:error] = @color.errors.full_messages.join('<br/>').html_safe
      render :new

    end
  end

  def destroy
    if @color.destroy
      redirect_to admin_colors_path
      flash[:success] =  t 'flash.color.success.deleted'
    else
      flash[:destroy] = t 'flash.color.fail.deleted'
    end
  end

  def color_params
    params[:color].permit!
  end

  def find_color
    @color = Color.find params[:id]
  end

end
