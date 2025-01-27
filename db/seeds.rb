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
  email: 'teste@teste.com',
  password: '123123',
  name: 'Gustavo',
  cpf: '123123'
)

# create products
products = [
  {
    name: "Smartphone Premium",
    description: "Um smartphone com tela AMOLED de 6.5 polegadas, câmera tripla de 50MP e 128GB de armazenamento. Perfeito para quem busca performance e estilo.",
    price_cents: 299_99,
    stock_quantity: 25,
    image_url: "https://images.pexels.com/photos/50614/pexels-photo-50614.jpeg?auto=compress&cs=tinysrgb&w=500&h=500&dpr=1"
  },
  {
    name: "Notebook Ultrafino",
    description: "Notebook ultrafino com processador Intel i7, 16GB de RAM, SSD de 512GB e bateria de longa duração. Ideal para trabalho e lazer.",
    price_cents: 599_99,
    stock_quantity: 15,
    image_url: "https://images.pexels.com/photos/265087/pexels-photo-265087.jpeg?auto=compress&cs=tinysrgb&w=500&h=500&dpr=1"
  },
  {
    name: "Fone de Ouvido Bluetooth",
    description: "Fone de ouvido sem fio com cancelamento de ruído ativo, som de alta qualidade e até 24 horas de bateria. Confortável e prático para o dia a dia.",
    price_cents: 129_99,
    stock_quantity: 50,
    image_url: "https://images.pexels.com/photos/18236754/pexels-photo-18236754/free-photo-of-cabo-fio-conexao-ligacao.jpeg?auto=compress&cs=tinysrgb&w=500&h=500&dpr=1"
  },
  {
    name: "Relógio Inteligente",
    description: "Relógio inteligente com monitoramento de atividades físicas, notificações em tempo real e resistência à água. Compatível com Android e iOS.",
    price_cents: 199_99,
    stock_quantity: 30,
    image_url: "https://images.pexels.com/photos/437037/pexels-photo-437037.jpeg?auto=compress&cs=tinysrgb&w=500&h=500&dpr=1"
  },
  {
    name: "Câmera DSLR",
    description: "Câmera DSLR com lente intercambiável de 18-55mm, sensor de alta resolução e modos automáticos para iniciantes e profissionais.",
    price_cents: 799_99,
    stock_quantity: 10,
    image_url: "https://images.pexels.com/photos/1787220/pexels-photo-1787220.jpeg?auto=compress&cs=tinysrgb&w=500&h=500&dpr=1"
  },
  {
    name: "Garrafa Térmica Inox",
    description: "Garrafa térmica de aço inoxidável com capacidade de 1 litro. Mantém bebidas quentes ou frias por até 12 horas. Ideal para uso diário ou viagens.",
    price_cents: 79_99,
    stock_quantity: 40,
    image_url: "https://images.pexels.com/photos/6606317/pexels-photo-6606317.jpeg?auto=compress&cs=tinysrgb&w=500&h=500&dpr=1"
  }
]

products.each do |product|
  Product.create!(product)
end
