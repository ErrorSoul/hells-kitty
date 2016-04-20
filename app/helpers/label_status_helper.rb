module LabelStatusHelper
  LABEL_TYPES = {
    new:      "label_admin label-info",
    process:  "label_admin label-warning",
    pay_ok:   "label_admin label-success",
    pay_error: "label_admin label-danger",

    free:  "label label-info",
    used:  "label label-success"
  }.freeze


  USER_TYPES = {
    user:  "label_admin label-info",
    montaj:  "label_admin label-warning",
    distributor:   "label_admin label-success",
  }

  def status_label(status)
    LABEL_TYPES[status.to_sym] if status
  end

  def user_label(status)
    USER_TYPES[status.to_sym] if status
  end
end
