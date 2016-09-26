GorgMessageSender.configure do |c|

  # Id used to set the event_sender_id
  c.application_id = RMQ_CONFIG["sender"]

  # RabbitMQ network and authentification
  #c.host = "localhost"
  c.host = RMQ_CONFIG["host"]
  #c.port = 5672
  c.port = RMQ_CONFIG["port"]
  #c.vhost = "/"
  c.vhost = RMQ_CONFIG["vhost"]
  #c.user = nil
  c.user = RMQ_CONFIG["user"]
  #c.password = nil
  c.password = RMQ_CONFIG["password"]

  # Exchange configuration
  #c.exchange_name ="exchange"
  c.exchange_name = RMQ_CONFIG["exchange_name"]

  #c.durable_exchange= true
end