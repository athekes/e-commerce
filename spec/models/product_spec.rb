require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }

    it { should validate_presence_of(:price_cents) }
    it { should validate_numericality_of(:price_cents).is_greater_than_or_equal_to(0) }
   
    it { should validate_presence_of(:stock_quantity) }
    it { should validate_numericality_of(:stock_quantity).is_greater_than_or_equal_to(0) }
  end

  describe "#price" do
    it "converts price_cents to price" do
      product = Product.new(price_cents: 1000)

      expect(product.price).to eq(10.0)
    end
  end
end
