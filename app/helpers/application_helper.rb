module ApplicationHelper
  include Orchid::ApplicationHelper

  def parse_md_brackets(query)
    if /\[(.*?)\]/.match(query)
      /\[(.*?)\]/.match(query)[1]
    #deal with values from ES that don't match the markdown pattern
    elsif /(.*)\(Apdp\w+\d{6}\)/.match(query)
      /(.*)\(Apdp\w+\d{6}\)/.match(query)[1]
    else
      query
    end
  end

  def parse_md_parentheses(query)
    /\]\((.*?)\)/.match(query)[1] if /\]\((.*?)\)/.match(query)
  end
end
