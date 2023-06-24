# frozen_string_literal: true
require_relative '../../lib/bunny/connection_manager.rb'

class ProductConsumer
  QUEUE = 'product_queue'

  def start_consuming
    channel = connection.create_channel
    queue = channel.queue(QUEUE, durable: true)

    queue.subscribe(manual_ack: true, block: true) do |_delivery_info, _metadata, message|
      message = JSON.parse(message)
      process_message(message)

      channel.ack(_delivery_info.delivery_tag)
    rescue StandardError
    end
  end

  private

  def connection
    @connection ||= ConnectionManager.instance.connection
  end

  def process_message(message)
    CreateItem.execute(message)
  end
end
