require 'httparty'
require 'json'

def fetch_repository_data(username)
  response = HTTParty.get("https://api.github.com/users/#{username}/repos")
  JSON.parse(response.body)
end

def find_most_starred_repository(repositories)
  repositories.max_by { |repo| repo['stargazers_count'].to_i }
end

def output_most_starred_repository(repository)
  puts "Most Starred Repository:"
  puts "Name: #{repository['name']}"
  puts "Description: #{repository['description'] || 'N/A'}"
  puts "Stars: #{repository['stargazers_count']}"
  puts "URL: #{repository['html_url']}"
end

begin
  print "Enter GitHub username: "
  username = gets.chomp
  repository_data = fetch_repository_data(username)
  most_starred_repository = find_most_starred_repository(repository_data)
  output_most_starred_repository(most_starred_repository)
rescue StandardError => e
  puts "An error occurred: #{e.message}"
end
