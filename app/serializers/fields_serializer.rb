class FieldsSerializer
  def self.dump(array)
    array
  end

  def self.load(array)
    (array || []).map(&:with_indifferent_access)
  end
end
