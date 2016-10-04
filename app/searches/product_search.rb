require "searchlight/adapters/action_view"

class ProductSearch < Searchlight::Search
  include Searchlight::Adapters::ActionView

  def base_query
    Product.all
  end

  def search_name
    query.where('products.name ilike :name', name: "%#{name.to_s}%")
  end

  def search_marking
    query.where('products.marking ilike :marking', marking: marking.to_s)
  end

  def search_category_id
    category = Category.find category_id
    case
    when category.children_count.zero?
      query.where(category_id: category_id)
    else
      cat_ids = category.leaves.select { |cat| cat.children_count == 0 }
      query.where(category_id: cat_ids)
      #query.joins('INNER JOIN categories AS parents ON parents.parent_id = :parent_id AND parents.children_count = 0', parent_id: category.id).where('category_id = parents.id')

    end

  end
end
