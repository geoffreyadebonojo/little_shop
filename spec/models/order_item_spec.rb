require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe "validations" do
    it { should validate_presence_of(:order_id) }
    it { should validate_presence_of(:item_id) }
    it { should validate_presence_of(:item_quantity) }
    it { should validate_presence_of(:item_price) }
  end
  describe "relationships" do
    it { should belong_to(:order) }
    it { should belong_to(:item) }
  end
end
