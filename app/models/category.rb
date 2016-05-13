# == Schema Information
#
# Table name: categories
#
#  id             :integer          not null, primary key
#  name           :string
#  parent_id      :integer
#  lft            :integer          not null
#  rgt            :integer          not null
#  depth          :integer          default("0"), not null
#  children_count :integer          default("0"), not null
#

class Category < ActiveRecord::Base
  acts_as_nested_set counter_cache: :children_count

  scope :only_children, -> do
    where.not(parent_id: nil)
      .where(
        "(SELECT count(*) FROM categories AS children WHERE categories.id = children.parent_id)= 0"
      )
  end

  def breadcrumb
    self_and_ancestors.map(&:name).join("/")
  end

  def self.only_children_to_json
    only_children
      .to_json(
        only: [:id, :name, :parent_id],
        methods: [:breadcrumb]
      )
  end
end
