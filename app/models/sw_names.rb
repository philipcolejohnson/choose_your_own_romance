require 'tatooine'

class SWNames
  def self.get_characters
    characters = []
    Tatooine::Person.list.each do |person|
      characters << person.name
    end
    characters
  end
end
