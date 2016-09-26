require 'mysql2'

class SoceGroupExtractor::SoceGroup

  attr_accessor :id
  attr_accessor :uuid
  attr_accessor :nom_groupe
  attr_accessor :nom_court

  def initialize(h)
    @id = h['id_groupe']
    @uuid = h['uuid']
    @nom_groupe = h['nom_groupe']
    @nom_court = h['nom_court']
  end

  def members_uuids
    conn=SoceGroupExtractor.mysql_conn
    escaped_id= conn.escape(self.id.to_s)
    query=<<END_SQL
      SELECT  u.uuid AS uuid
      FROM liens_users_groupes AS lug
      INNER JOIN users AS u
      ON lug.id_user = u.id_user
      WHERE lug.id_groupe=#{escaped_id};
END_SQL

    conn.query(query).to_a.map{|x| x['uuid']}
  end


  def self.retrieve_all
    conn=SoceGroupExtractor.mysql_conn
    raw_data=conn.query('SELECT id_groupe,uuid,nom_groupe,nom_court FROM groupes;').to_a
    raw_data.map{|d| self.new(d)}
  end

end