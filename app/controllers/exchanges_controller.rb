class ExchangesController < ApplicationController
  def index
    puts params.inspect + nil
    render nothing: true
  end
end
