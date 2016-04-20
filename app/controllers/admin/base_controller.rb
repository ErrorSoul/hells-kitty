class Admin::BaseController < ApplicationController
  layout 'admin'

  prepend_view_path 'app/views/admin'

  before_filter :authenticate_admin!
end
