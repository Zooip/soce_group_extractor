require 'gorg_message_sender'

class SoceGroupExtractor::GramGroup

  attr_accessor :uuid
  attr_accessor :name
  attr_accessor :short_name
  attr_accessor :description
  attr_accessor :members

  def self.from_soce_group(soce_group)
    result=self.new

    result.uuid=soce_group.uuid
    result.name=soce_group.nom_groupe
    result.short_name=soce_group.nom_court

    result.members=soce_group.members_uuids

    result
  end

  def serialize
    {
      uuid: @uuid,
      name: @name,
      short_name: @short_name,
      description: @description,
      members: @members
    }
  end

  def commit(message_sender: GorgMessageSender.new)
    message_sender.send_message(self.serialize, 'request.gram.group.update')
  end


end