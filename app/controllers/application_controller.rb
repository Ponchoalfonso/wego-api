class ApplicationController < ActionController::API
  before_action :authenticate_user!, :admin_only
  
  def render_resource(resource)
    if resource.errors.empty?
      render json: resource
    else
      validation_error(resource)
    end
  end

  def validation_error(resource)
    render json: {
      errors: [
        {
          status: '400',
          title: 'Bad Request',
          detail: resource.errors,
          code: '100'
        }
      ]
    }, status: :bad_request
  end

  protected
    def application_type
      request.headers['Application']
    end

    def admin_only
      if current_user&.role.name != 'admin'
        head 403
      end
    end

    def driver_only
      if application_type != 'Drivers'
        head 400
      end
    end

    def customer_only
      if application_type != 'Customers'
        head 400
      end
    end
end
