require 'csv'
require 'rest_client'

class ImportCustomer
  attr_reader :common_url, :version, :file

  ADDRESS_COLUMNS = %w[company address1 address2 city province country zip province_code country_code country_name default].freeze

  HEADERS = {
    content_type: :json, accept: :json, 'X-Shopify-Access-Token': Rails.application.credentials.shopify[:token]
  }.freeze

  def initialize(file, common_url, version)
    @file = file
    @common_url = common_url
    @version = version
  end

  def import
    url = "#{common_url}/admin/api/#{version}/customers"
    CSV.foreach(file.path, headers: true) do |row|
      converted_hash = row.to_h.transform_keys{|k| k.parameterize.underscore}
      converted_hash.delete_if { |_, v| v.blank? }
      # converted_hash.transform_keys!(&:to_sym)
      customer_hash = converted_hash.slice!(*ADDRESS_COLUMNS)
      customer_hash['addresses'] = [converted_hash]
      customer = { "customer" => customer_hash }
      binding.pry
      response = RestClient.post(url, customer.to_json, HEADERS)
      # c = ShopifyAPI::Customer.create(customer)
    end
  end
end

