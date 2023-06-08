class Publisher
  def self.connection
    conn = Bunny.new(automatically_recover: false)
    conn.start
  end

  def self.channel
    ch = connection.create_channel
    ch.queue("hello")
  end

  def self.publish(message)
    channel.publish(message.to_json, routing_key: channel.name)
    connection.close
  end
end
