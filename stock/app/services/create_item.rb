class CreateItem
  def self.execute(body)
    Item.create(
      name: body["name"],
      unity: body["unity"],
      color: body["color"]
    )
  end
end
