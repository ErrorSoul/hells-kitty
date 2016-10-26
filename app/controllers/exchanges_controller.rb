class ExchangesController < ApplicationController
  def index
    puts params.inspect
    if params[:type] == 'catalog'
      if params[:mode] == 'checkauth'
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
