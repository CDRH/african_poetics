class Education < ApplicationRecord
  belongs_to :person
  belongs_to :university

  def name
    if university
      "#{year_ended} #{degree}: #{uni_name}"
    end
  end

  def person_name
    person.name
  end

  def uni_name
    university.name
  end

end
