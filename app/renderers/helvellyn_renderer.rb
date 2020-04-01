class HelvellynRenderer < Redcarpet::Render::HTML
  def list_item(text, list_type)
    if list_type == :unordered && text.start_with?("[x]", "[X]")
      text[0..2] = %(<input type="checkbox" checked="checked">)
    elsif list_type == :unordered && text.start_with?("[ ]")
      text[0..2] = %(<input type="checkbox">)
    end

    %(<li>#{text}</li>)
  end
end