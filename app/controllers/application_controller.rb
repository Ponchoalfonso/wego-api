class ApplicationController < ActionController::API
  before_action :authenticate_user!
  
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
        head(403)
      end
    end
end
