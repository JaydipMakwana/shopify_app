require 'csv'
require 'rest_client'

class ImportCustomer
  attr_reader :common_url, :version, :file

  ADDRESS_COLUMNS = %w[company address1 address2 city province country zip province_code country_code country_name default].freeze
  attr_reader :common_url, :version, :token, :file

  HEADERS =
    { 'Content-Type' => 'application/json', 'X-Shopify-Access-Token' => Rails.application.credentials.shopify[:token] }.freeze

  def initialize(file, common_url, version)
    @file = file
    @common_url = common_url
    @version = version
  end

  def import
    url = "#{common_url}/admin/api/2020-01/customers.json"
    CSV.foreach(file.path, headers: true) do |row|
      converted_hash = row.to_h.transform_keys{|k| k.parameterize.underscore}
      converted_hash.delete_if { |_, v| v.blank? }
      # converted_hash.transform_keys!(&:to_sym)
      customer_hash = converted_hash.slice!(*ADDRESS_COLUMNS)
      customer_hash['addresses'] = [converted_hash]
      customer = { "customer" => customer_hash }
      response = HTTParty.post(url, body: customer.to_json, headers: HEADERS)
      #response = RestClient.post(url, dummy_customer.to_json, headers= HEADERS)
      # c = ShopifyAPI::Customer.create(customer)
    end
  end


  def dummy_customer
    {
      "customer"=> {
        "first_name"=> "Steve",
        "last_name"=> "Lastnameson",
        "email"=> "steve.lastnameson@example.com",
        "phone"=> "+15142546011",
        "verified_email"=> true,
        "addresses"=> [
          {
            "address1"=> "123 Oak St",
            "city"=> "Ottawa",
            "province"=> "ON",
            "phone"=> "555-1212",
            "zip"=> "123 ABC",
            "last_name"=> "Lastnameson",
            "first_name"=> "Mother",
            "country"=> "CA"
          }
        ]
      }
    }
  end
end


