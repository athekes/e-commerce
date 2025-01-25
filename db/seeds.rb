# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# create user
User.create!(
  email: 'lgx.0097@gmail.com',
  password: '123123',
  name: 'Gustavo',
  cpf: '123123'
)

# create products
10.times do |i|
  Product.create!(
    name: "Product #{i + 1}",
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras risus sapien, molestie sed urna eu, tincidunt elementum turpis. Praesent bibendum tempus ligula sed rhoncus. Quisque efficitur nisl id sem tempor pretium. Suspendisse efficitur nisi orci, id suscipit risus accumsan tempus. Aliquam volutpat mi vitae dolor mollis, nec tempus augue tincidunt. Praesent sed vehicula purus, non imperdiet neque. Vivamus viverra, justo non mattis aliquam, arcu nulla ultrices justo, id rhoncus velit sapien non eros. Cras commodo enim sed eros aliquet faucibus. Donec tincidunt nibh a posuere sollicitudin.",
    price_cents: 1000 + i * 100,
    stock_quantity: 10 + i,
    image_url: "https://picsum.photos/200/300"
  )
end
