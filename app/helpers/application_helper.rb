module ApplicationHelper
  def has_error(model, attr)
    "has-error" if model.errors[attr].present?
  end
end
