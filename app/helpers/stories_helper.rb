module StoriesHelper
  def save_choice
    numbers = {
      1 => "one",
      2 => "two",
      3 => "three",
      4 => "four",
      5 => "five",
      6 => "six"
    }
    @story.update("#{numbers[@chapter]}_choice".to_sym => params[:path])
  end

  def get_chapter_text(story, chapter)
    numbers = {
      1 => "one",
      2 => "two",
      3 => "three",
      4 => "four",
      5 => "five",
      6 => "six"
    }

    case story.send("#{numbers[chapter - 1]}_choice".to_sym)
    when 1
      text = story.send("#{numbers[chapter]}_a".to_sym)
    when 2
      text = story.send("#{numbers[chapter]}_b".to_sym)
    when 3
      text = story.send("#{numbers[chapter]}_c".to_sym)
    end
    text
  end

  def save_beginning
    scraper = RomanceCrawler.new
    @story.update(one: clean_passages([scraper.get_choices(1).first]).first)
  end

  def save_next_chapters(story, chapter)
    numbers = {
      1 => "one",
      2 => "two",
      3 => "three",
      4 => "four",
      5 => "five",
      6 => "six"
    }
    scraper = RomanceCrawler.new
    choices = scraper.get_choices(3)
    story.update("#{numbers[chapter]}_a".to_sym => choices[0],
                 "#{numbers[chapter]}_b".to_sym => choices[1],
                 "#{numbers[chapter]}_c".to_sym => choices[2])

    choices
  end

  def load_chapter(story, chapter)
    numbers = {
      1 => "one",
      2 => "two",
      3 => "three",
      4 => "four",
      5 => "five",
      6 => "six"
    }
    choices = []
    p story.send("#{numbers[chapter]}_a".to_sym)
    choices << story.send("#{numbers[chapter]}_a".to_sym)
    choices << story.send("#{numbers[chapter]}_b".to_sym)
    choices << story.send("#{numbers[chapter]}_c".to_sym)
    choices
  end

  def strip_text(text)
    text.gsub("\n", "<br>")
  end

  def clean_passages(passages)
    passages.each_index do |index|
      passages[index] = strip_text(passages[index])
    end
    passages
  end

  def get_choice_words(passages)
    choices = Array.new(passages.size)
    passages.each_index do |index|
      choices[index] = passages[index].split(" ").sample
    end
    choices
  end

  def next_chapter
    session['chapter'] = session['chapter'].to_i + 1
  end
end
