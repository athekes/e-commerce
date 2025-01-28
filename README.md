# E-commerce Application

Este é um projeto de e-commerce desenvolvido com Ruby on Rails. Abaixo está uma breve documentação sobre a organização do projeto, focando nos models, relações mais importantes, controllers e rotas.

## Models

### User

Representa um usuário da plataforma. Com ele é possível o cadastro e login com CPF/email e senha.

- **Relações**: Ele `has_one :cart` e `has_many :orders`

### Product

Representa um produto disponível para compra. O produto também possui a quantidade disponível em estoque.

### Cart

Representa o carrinho de compras de um usuário.

- **Relações**: Ele `belongs_to :user` e `has_many: cart_items`

### CartItem

Representa um item dentro de um carrinho. Um cart item só é válido se respeitar a quantidade em estoque .do produto

- **Relações**: Ele `belogns_to: cart` e ` belongs_to: product`

### AddToCart

Serviço responsável por adicionar um item ao carrinho.

### Order

Representa um pedido realizado por um usuário.

- **Relações**: Ele `belongs_to :user` e `has_many :order_items`

### OrderItem

Representa um item dentro de um pedido.

- **Relações**: Ele `belongs_to :order` e `belongs_to :product`

### CreateOrderFromCart

Serviço responsável por criar um pedido a partir de um carrinho e descontar do estoque a quantidade correta de cada produto do pedido.

## Controllers

### ProductsController

- **Ações**: `index`, `show`

### OrdersController

- **Ações**: `index`, `show`, `create`

### CartsController

- **Ações**: `show`

### CartItemsController

- **Ações**: `create`, `update`, `destroy`

## Comportamento dinâmico

O comportamento dinâmico nas views foi majoritariamente gerenciado pelo uso das features do hotwire (Turbo Drive/Stimulus) disponíveis no rails 8.
