class ExchangesController < ApplicationController
  def index
    puts params.inspect
    if params[:type] == 'catalog'
      if params[:mode] == 'checkauth'
        render text: "success\n"
      elsif params[:mode] == 'init'
        render text: "zip=yes\n"
      end
    end
  end
end
