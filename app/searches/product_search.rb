require "searchlight/adapters/action_view"

class ProductSearch < Searchlight::Search
  include Searchlight::Adapters::ActionView

  def base_query
    Product.all
  end

  def search_name
    query.where('products.name ilike :name', name: name.to_s)
  end

  def search_marking
    query.where('products.marking ilike :marking', marking: marking.to_s)
  end

  def search_category_id
    category = Category.find category_id
    case
    when category.parent_id.nil?

      cat_ids = category.self_and_descendants.where(children_count: 0).pluck(:id)
      query.where(category_id: cat_ids)
    when category.depth == 1

      cat_ids = category.self_and_descendants.where(children_count: 0).pluck(:id)
      query.where(category_id: cat_ids)
    when category.children_count == 0

      query.where(category_id: category_id)
    else
      nil
    end
  end
end
