
class ContentEntryValidator < ActiveModel::EachValidator
  # {"title"=>"My First Post", "content"=>"<p>Here we go... again.</p>"}

  # TODO: Validate:
  #       - against schema of template ??
  # Perhaps we could retrieve the fields array as a Schema?
  # Maybe a good first step would be to see about presenting the schema to admins.. How should it be expected to look?

  def validate_each(record, attribute, value)
    # schema = record.template.fields
    # options[:schema] couldn't be passed directly as validates is a class method, unaware of the instance
  end
end
