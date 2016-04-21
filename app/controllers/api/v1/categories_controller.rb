class Api::V1::CategoriesController < ApplicationController

  def index
    @categories = Category.roots.includes(children: :children).as_json(include: {children: {include: :children}})
    render json: { categories: @categories }
  end

  def create
    @category = Category.new category_params

    if @category.save
      render json: { category: @category }
    else
      render json: { error: 'error' }
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
       render json: { category: @category }
    else
      render json: { error: 'error' }
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      render json: { ok: 'ok'}
    else
      render json: { error: 'error' }
    end
  end

  def category_params
    params[:category].permit!
  end
end
