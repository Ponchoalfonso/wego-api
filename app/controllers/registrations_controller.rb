class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)

    resource.save
    render_resource(resource)
  end

  private
    def sign_up_params
      params.require(:user).permit(
        :email, :password, :password_confirmation, :name, :last_name, :second_last_name, :birthday, :phone_number
      )
    end
end