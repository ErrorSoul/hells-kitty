module ApplicationHelper
  def has_error(model, attr)
    "has-error" if model.errors[attr].present?
  end

  def convert_boolean(attr)
    attr ? :_true : :_false
  end
end
