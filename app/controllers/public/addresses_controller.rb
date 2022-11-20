class Public::AddressesController < Public::BaseController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  def index
    @address = Address.new
    @addresses = current_customer.addresses
  end

  def create
    @address = current_customer.addresses.new(address_params)
    if @address.save
      redirect_to addresses_path
    else
      @address = Address.new
      @addresses = current_customer.addresses
      render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path
    else
      render :edit
    end
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end

  def is_matching_login_user
    address = Address.find_by(id: params[:id])
    if current_customer.id != address.customer_id
      redirect_to addresses_path
    end
  end
end
