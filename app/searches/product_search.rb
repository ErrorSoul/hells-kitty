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
end
