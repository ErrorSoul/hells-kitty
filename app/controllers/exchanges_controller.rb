class ExchangesController < ApplicationController
  def index
    puts params.inspect
    render nothing: true
  end
end
