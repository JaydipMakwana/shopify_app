# frozen_string_literal: true

class HomeController < AuthenticatedController
  def index
    @products = ShopifyAPI::Product.find(:all, params: { limit: 10 })
    @webhooks = ShopifyAPI::Webhook.find(:all)
  end

  def customers
    @customers = ShopifyAPI::Customer.find(:all)
    respond_to do |format|
      format.json { render json: @customers  }
    end
  end
end
