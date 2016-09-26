$:.unshift File.dirname(__FILE__)

require 'extra_config'
require 'gorg_message_sender'

DB_CONFIG=ExtraConfig.new(File.expand_path("database.yml",File.dirname(__FILE__)),"SGE_DB")
RMQ_CONFIG=ExtraConfig.new(File.expand_path("rabbitmq.yml",File.dirname(__FILE__)),"SGE_RMQ")
require 'soce_group_extractor/rabbit_mq_config'

class SoceGroupExtractor

  def self.mysql_conn
    @conn||= Mysql2::Client.new(
        :host => DB_CONFIG[:mysql_host],
        :port => DB_CONFIG[:mysql_port],
        :username => DB_CONFIG[:mysql_user],
        :password => DB_CONFIG[:mysql_pass],
        :database => DB_CONFIG[:mysql_db]
    )
  end

  def process
    sender=GorgMessageSender.new
    SoceGroup.retrieve_all.each do |sg|
      GramGroup.from_soce_group(sg).commit(message_sender: sender)
    end
  end
end

require 'soce_group_extractor/soce_group'
require 'soce_group_extractor/gram_group'