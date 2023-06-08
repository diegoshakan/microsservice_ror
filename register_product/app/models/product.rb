class Product < ApplicationRecord
  after_create :publish_product

  private

  def publish_product
    Publisher.publish(self.attributes.except("id", "created_at", "updated_at"))
  end
end
