class MainsController < ApplicationController
  layout 'main'

  def index
    @categories = Category.roots.includes(:children)
  end

  def list
    @categories = Category.roots.includes(:children)
  end

end
