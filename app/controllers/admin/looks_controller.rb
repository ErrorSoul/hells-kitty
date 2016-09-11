class Admin::LooksController < Admin::BaseController

  before_action :find_look, only: [:show, :edit, :update, :destroy]

  def index
    @looks = Look.all
  end

  def new
    @look = Look.new
  end

  def show; end

  def edit; end

  def update
    if @look.update_attributes look_params
      redirect_to admin_look_path(@look)
      flash[:success] = t 'flash.look.success.updated'
    else
      flash[:error] = @look.errors.full_messages.join('<br/>').html_safe
      render :edit
    end
  end

  def create
    @look = Look.new look_params

    if @look.save
      redirect_to admin_look_path(@look)
      flash[:success] = t 'flash.look.success.created'
    else
      flash[:error] = @look.errors.full_messages.join('<br/>').html_safe
      render :new

    end
  end

  def destroy
    if @look.destroy
      redirect_to admin_looks_path
      flash[:success] =  t 'flash.look.success.deleted'
    else
      flash[:destroy] = t 'flash.look.fail.deleted'
    end
  end

  def look_params
    params[:look].permit!
  end

  def find_look
    @look = Look.find params[:id]
  end

end
