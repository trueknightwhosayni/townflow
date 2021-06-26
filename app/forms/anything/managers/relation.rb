class Anything::Managers::Relation
  def self.build_relation(params)
  end

  def self.serialize_params(value)
    Array.wrap Neewom::Collection.serialize(value)
  end

  def self.deserialize_params(value)
    value.map { |item| Neewom::Collection.deserialize(item) }
  end
end
