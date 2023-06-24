Rails.application.config.after_initialize do
  puts "STARTING ProductConsumer.new.start_consuming"
  Thread.new do
    ProductConsumer.new.start_consuming
  end
end