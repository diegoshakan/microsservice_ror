class CreateItem
  def self.execute(body)
    begin
      Item.find_or_create_by(
        name: body["name"],
        unity: body["unity"],
        color: body["color"]
      )
    rescue StandardError
    end
  end
end
