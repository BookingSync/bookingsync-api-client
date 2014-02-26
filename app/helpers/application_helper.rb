module ApplicationHelper
  def pretty_json(object_or_string)
    object_or_string = JSON.parse(object_or_string) if object_or_string.is_a?(String)
    JSON.pretty_generate(object_or_string)
  end

  def pretty_headers(response)
    response.headers.map { |header, value| "#{header}: #{value}" }.join("\n")
  end
end
