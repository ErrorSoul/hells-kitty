class ProductSearch < Searchlight::Search
  def base_query
    Category.all
  end

  def search_name
    search.joins('INNER JOIN categories AS parents ON parents.id = categories.parent_id')
      .where('categories.id = :id OR categories.name ilike :name OR parents.name ilike :name', id: name.to_i, name: str(name))
  end
end
