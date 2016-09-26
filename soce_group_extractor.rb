$:.unshift File.dirname(__FILE__)

require 'extra_config'
require 'gorg_message_sender'

CURRENT_ENV=ENV['SGE_ENV']||'no_env'

DB_CONFIG=ExtraConfig.new(File.expand_path("database.yml",File.dirname(__FILE__)),"SGE_DB",CURRENT_ENV)
RMQ_CONFIG=ExtraConfig.new(File.expand_path("rabbitmq.yml",File.dirname(__FILE__)),"SGE_RMQ",CURRENT_ENV)
require 'soce_group_extractor/rabbit_mq_config'

class SoceGroupExtractor

  def process
    sender=GorgMessageSender.new
    SoceGroup.retrieve_all.each do |sg|
      self.class.logger.info "Processing #{sg.nom_groupe}"
      GramGroup.from_soce_group(sg).commit(message_sender: sender)
      self.class.logger.info "Process #{sg.nom_groupe} done"
    end
  end

  def self.mysql_conn
    @conn||= Mysql2::Client.new(
        :host => DB_CONFIG[:mysql_host],
        :port => DB_CONFIG[:mysql_port],
        :username => DB_CONFIG[:mysql_user],
        :password => DB_CONFIG[:mysql_pass],
        :database => DB_CONFIG[:mysql_db]
    )
  end


  def self.logger
    @logger||=Logger.new(STDOUT)
  end
end

require 'soce_group_extractor/soce_group'
require 'soce_group_extractor/gram_group'