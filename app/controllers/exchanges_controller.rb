class ExchangesController < ApplicationController

  skip_before_action :verify_authenticity_token, only: :create
  def index
    puts params.inspect
    if params[:type] == 'catalog'
      if params[:mode] == 'checkauth'
        #puts request.inspect
        render text: "success\n"
      elsif params[:mode] == 'init'
        render text: "zip=yes\nfile_limit=2000\n"
      end
    end
  end

  def create
    puts params.inspect
  end
end
