class WorkRole < ApplicationRecord

  belongs_to :person
  belongs_to :role
  belongs_to :work

  def name
    if person && role
      "#{person.name} (#{role.name})"
    end
  end

end
