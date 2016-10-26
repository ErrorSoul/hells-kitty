class ExchangesController < ApplicationController
  def index
    puts params.inspect
    if params[:type] == 'catalog'
      render nothing: true
    end
  end
end
