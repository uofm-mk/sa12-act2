require 'net/http'
require 'json'

def fetch_cryptocurrency_data
  uri = URI('https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd')
  response = Net::HTTP.get(uri)
  JSON.parse(response)
end

def extract_top_5_cryptocurrencies(data)
  data.sort_by { |crypto| -crypto['market_cap'] }.take(5)
end

def output_top_5_cryptocurrencies(cryptocurrencies)
  puts "Top 5 Cryptocurrencies by Market Capitalization:"
  puts "-------------------------------------------------"
  cryptocurrencies.each do |crypto|
    puts "Name: #{crypto['name']}"
    puts "Price: $#{crypto['current_price']}"
    puts "Market Cap: $#{crypto['market_cap']}"
    puts "-------------------------------------------------"
  end
end

begin
  cryptocurrency_data = fetch_cryptocurrency_data
  top_5_cryptocurrencies = extract_top_5_cryptocurrencies(cryptocurrency_data)
  output_top_5_cryptocurrencies(top_5_cryptocurrencies)
rescue StandardError => e
  puts "An error occurred: #{e.message}"
end
