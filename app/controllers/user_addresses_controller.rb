class UserAddressesController < ApplicationController
  before_action :application_only
  skip_before_action :admin_only

  def show
    @address = current_user.address

    if @address.nil?
      head 404
    end
  end

  def create
    @address = Address.new(address_params)

    if current_user.address.nil?
      @address.user = current_user
      if @address.save
        render :show, status: :created
      else
        render json: @address.errors, status: :unprocessable_entity
      end
    else
      head 403
    end
  end

  def update
    @address = current_user.address

    if @address.nil?
      return head 404
    end

    if @address.update(address_params)
      render :show
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  def address_params
    params.require(:address).permit(:country, :state, :city, :suburb, :street_address, :interior, :zip_code)
  end
end
