class CustomersController < ApplicationController

  def index
    @customers = ShopifyAPI::Customer.find(:all)
    respond_to do |format|
      format.html
      format.json { render json: @customers  }
    end
  end

  def import
    import_customer = ImportCustomer.new(params[:file], @url, @api_version).import
  end
end
