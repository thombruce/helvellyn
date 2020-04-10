
class FieldsValidator < ActiveModel::EachValidator
  # Maybe rename to ContentModelValidator for consistency.

  VALID_FIELD_TYPES = ['String', 'Text', 'Rich Text'].freeze

  def validate_each(record, attribute, value)
    validates_uniqueness_of_slugs(record, attribute, value)
    validates_only_one_sluggable_field(record, attribute, value)
    validates_sluggable_field_is_a_string(record, attribute, value)
    validates_fields_do_not_conflict_with_reserved_names(record, attribute, value)

    value.each do |field|
      record.errors[:base] << 'Fields must have a name.' unless field[:name].present?
      record.errors[:base] << 'Invalid field type.' unless VALID_FIELD_TYPES.include? field[:type]
    end
  end

  private

  def validates_uniqueness_of_slugs(record, attribute, value)
    slugs = value.map { |field| field[:slug] }
    record.errors[:base] << 'Field names must be unique.' unless slugs.uniq.length == slugs.length
  end

  def validates_only_one_sluggable_field(record, attribute, value)
    record.errors[:base] << "Only one field may be used as a slug" if value.select { |field| field[:sluggable] }.count > 1
  end

  def validates_sluggable_field_is_a_string(record, attribute, value)
    record.errors[:base] << "Only a string field may be used as a slug" if value.select { |field| field[:sluggable] && field[:type] != 'String' }.any?
  end

  def validates_fields_do_not_conflict_with_reserved_names(record, attribute, value)
    record.errors[:base] << "Field names contain reserved words" unless (options[:reserved].map(&:to_s) & value.map { |field| field[:slug] }).empty?
  end
end