require 'net/http'
require 'json'

def fetch_time_data(area, location)
  uri = URI("http://worldtimeapi.org/api/timezone/#{area}/#{location}")
  response = Net::HTTP.get(uri)
  JSON.parse(response)
end

def format_time(datetime)
  Time.parse(datetime).strftime("%Y-%m-%d %H:%M:%S")
end

def output_current_time(area, location, datetime)
  formatted_time = format_time(datetime)
  puts "The current time in #{area}/#{location} is #{formatted_time}."
end

begin
  print "Enter area: "
  area = gets.chomp
  print "Enter location: "
  location = gets.chomp
  time_data = fetch_time_data(area, location)
  current_time = time_data['datetime']
  output_current_time(area, location, current_time)
rescue StandardError => e
  puts "An error occurred: #{e.message}"
end
