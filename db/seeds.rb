# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

comic = Comic.new(
  title: "In the Beginning",
  description: "Starter comic page",
  publish_date: DateTime.new(2000,1,1),
  is_published: true
)
comic.image.attach io: File.open(Rails.root.join('db/images/default.png')), filename: "default.png"
comic.save!
