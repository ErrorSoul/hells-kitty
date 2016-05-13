class CategorySearch < Searchlight::Search
  def base_query
    Category.all.order(id: :desc)
  end

  def search_name
    query.joins('INNER JOIN categories AS parents ON parents.id = categories.parent_id')
      .where('categories.id = :id OR categories.name ilike :name OR parents.name ilike :name', id: name.to_i, name: name)
  end
end
