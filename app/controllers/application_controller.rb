class ApplicationController < ActionController::Base
  include ShopifyApp::Authenticated
  skip_before_action :verify_authenticity_token
  before_action :common_url_and_token
  # protect_from_forgery with: :null_session

  private

  def common_url_and_token
    @url = "https://#{@shop_session.domain}"
    @api_version = @shop_session.api_version.handle
  end
end
