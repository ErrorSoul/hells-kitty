class ExchangesController < ApplicationController
  def index
    puts params.inspect
    puts ""
    render nothing: true
  end
end
