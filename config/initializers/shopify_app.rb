ShopifyApp.configure do |config|
  config.application_name = "HerokuTesting"
  config.api_key = Rails.application.credentials.shopify[:api_key]
  config.secret = Rails.application.credentials.shopify[:secret_key]
  config.old_secret = ""
  config.scope = "read_products, write_products, read_customers, write_customers, read_orders, write_orders, read_product_listings, read_price_rules, write_price_rules, read_discounts, write_discounts" # Consult this page for more scope options:
                                 # https://help.shopify.com/en/api/getting-started/authentication/oauth/scopes
  config.embedded_app = false
  config.after_authenticate_job = false
  config.api_version = "2020-01"
  config.session_repository = 'Shop'
end

# ShopifyApp::Utils.fetch_known_api_versions                        # Uncomment to fetch known api versions from shopify servers on boot
# ShopifyAPI::ApiVersion.version_lookup_mode = :raise_on_unknown    # Uncomment to raise an error if attempting to use an api version that was not previously known
