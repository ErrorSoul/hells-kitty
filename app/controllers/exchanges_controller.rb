class ExchangesController < ApplicationController
  def index
    puts params.inspect
    if params[:type] == 'catalog'
      render text: "success\n"
    end
  end
end
