class UserVehiclesController < ApplicationController
  skip_before_action :admin_only
end
