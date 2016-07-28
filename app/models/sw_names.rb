require 'tatooine'

class SWNames
  def self.get_characters
    characters = []
    Tatooine::Person.list.each do |person|
      characters << person.name
    end
    3.times do
      Tatooine::Person.next.each do |person|
        characters << person.name
      end
    end
    characters
  end
end
