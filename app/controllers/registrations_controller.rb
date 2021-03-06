class RegistrationsController < Devise::RegistrationsController
  skip_before_action :authenticate_user!, :admin_only
  
  respond_to :json

  def create
    build_resource(sign_up_params)
    if application_type == 'Customers'
      resource.role = Role.where(name: 'customer').take
    elsif application_type == 'Drivers'
      resource.role = Role.where(name: 'driver').take
    else
      return head 400
    end

    resource.save
    sign_in resource
    render_resource(resource)
  end

  private
    def sign_up_params
      params.require(:user).permit(
        :email, :password, :password_confirmation, :name, :last_name, :second_last_name, :birthday, :phone_number
      )
    end
end