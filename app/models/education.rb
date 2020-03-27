class Education < ApplicationRecord
  belongs_to :person
  belongs_to :university

  def name
    if person && university
      "#{person_name}, #{uni_name} (#{degree})"
    end
  end

  def person_name
    person.name
  end

  def uni_name
    university.name
  end

end
