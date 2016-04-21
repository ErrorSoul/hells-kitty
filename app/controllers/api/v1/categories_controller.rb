class Api::V1::CategoriesController < ApplicationController
  def index
    @categories = Category.roots.includes(children: :children).as_json(include: {children: {include: :children}})
    render json: { categories: @categories }
  end
end
