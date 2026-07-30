# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
olivia = User.find_or_create_by!(email_address: "olivia@example.com") do |user|
  user.name = "Olivia"
  user.password = "password"
end

james = User.find_or_create_by!(email_address: "james@example.com") do |user|
  user.name = "James"
  user.password = "password"
end

lucas = User.find_or_create_by!(email_address: "lucas@example.com") do |user|
  user.name = "Lucas"
  user.password = "password"
end

Post.find_or_create_by!(body: "今日は推しぬいとこの場所に遊びに来た！") do |post|
  post.user = olivia
end

Post.find_or_create_by!(body: "今日も推しが可愛い！") do |post|
  post.user = james
end

Post.find_or_create_by!(body: "推しとの写真を撮るのにおすすめ！") do |post|
  post.user = lucas
end

Admin.create!(
  email_address: "admin@example.com",
  password: "password"
)