require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    subject { User.new(cpf: '12345678900', email: 'test@example.com') }

    it { should validate_presence_of(:cpf) }
    it { should validate_length_of(:cpf).is_at_most(11) }
    it { should validate_uniqueness_of(:cpf).case_insensitive }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end
end
