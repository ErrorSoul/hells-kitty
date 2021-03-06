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
    puts request.inspect
    puts '----------------------------------------------'
    puts request.body
    puts request.raw_post.inspect
    puts params.inspect
    puts some_params.inspect
    puts some_params[:filename].class
    File.open("tmp/1c_#{12}.zip", 'wb') do |f|
      f.write request.body.read
    end
    render text: "success\n"
  end

  private

  def some_params
   params.permit(:filename)
  end
end
