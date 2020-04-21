
class FieldsValidator < ActiveModel::EachValidator
  # Maybe rename to ContentModelValidator for consistency.

  VALID_FIELD_TYPES = [
    'String',
    'Text',
    'Rich Text',
    'Date'
  ].freeze

  def validate_each(record, attribute, value)
    validates_uniqueness_of_slugs(record, attribute, value)
    validates_fields_do_not_conflict_with_reserved_names(record, attribute, value)

    value.each do |field|
      record.errors[:base] << 'Fields must have a name.' unless field[:name].present?
      record.errors[:base] << 'Invalid field type.' unless VALID_FIELD_TYPES.include? field[:type]
      record.errors[:base] << 'Invalid field name.' unless field[:slug].match /\A(?:[a-z0-9]+_?)*[a-z0-9]+\z/
      record.errors[:base] << 'Field name cannot contain only numbers.' if field[:slug].match /\A\d+\Z/
    end
  end

  private

  def validates_uniqueness_of_slugs(record, attribute, value)
    slugs = value.map { |field| field[:slug] }
    record.errors[:base] << 'Field names must be unique.' unless slugs.uniq.length == slugs.length
  end

  def validates_fields_do_not_conflict_with_reserved_names(record, attribute, value)
    record.errors[:base] << "Field names contain reserved words" unless (options[:reserved].map(&:to_s) & value.map { |field| field[:slug] }).empty?
  end
end