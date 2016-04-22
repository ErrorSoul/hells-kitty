class MainsController < ApplicationController
  layout 'main'

  def index
    @categories = Category.roots.includes(:children)
  end

end
