# frozen_string_literal: true

class ConnectionManager
  attr_accessor :active_connection, :active_channel

  include Singleton

  def initialize
    establish_connection
  end

  def establish_connection
    @active_connection = bunny_connection_initialize
    active_connection.start
    @active_channel = active_connection.create_channel

    @active_connection
  end

  def connection
    return active_connection if connected?

    establish_connection

    active_connection
  end

  def channel
    return active_channel if connected? && active_channel&.open?

    establish_connection

    active_channel
  end

  def publish_to_queue(queue_name, message, durable = true)
    queue = channel.queue(queue_name, durable:)
    channel.default_exchange.publish(message, routing_key: queue.name)
  end

  def connected?
    active_connection&.connected?
  end

  private

  def bunny_connection_initialize
    @bunny_connection_initialize || initialize_connection
  end

  def initialize_connection
    connect_development
  end

  def connect_development
    Bunny.new(automatically_recover: false)
  end
end
