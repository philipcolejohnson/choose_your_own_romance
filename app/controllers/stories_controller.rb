class StoriesController < ApplicationController
  def new
    @story = Story.new
    @story.save
    session['chapter'] = 1
    save_beginning
  end

  def edit
    @chapter = session['chapter'].to_i
    @story = Story.find(params[:id])
    save_next_chapters(@story, @chapter + 1) # unless @chapter == 6

    if @chapter == 1
      @current_chapter = @story.one
    else
      @current_chapter = get_chapter_text(@story, @chapter)
    end

    # if @chapter < 6
      @choices = save_next_chapters(@story, @chapter + 1)
      @words = get_choice_words(@choices)
      @choices = clean_passages(@choices)
    # end
  end

  def update
    @chapter = session['chapter'].to_i
    @story = Story.find(params[:id])
    save_choice
    if @chapter < 5
      next_chapter
      redirect_to edit_story_path(@story)
    else
      redirect_to story_path(@story)
    end
  end

  def show
    @story = Story.find(params[:id])
  end

  def index
    @stories = Story.all
  end

  def destroy
    @story = Story.find(params[:id])
    @story.destroy
    redirect_to stories_path
  end

  private

  def save_choice
    numbers = {
      1 => "one",
      2 => "two",
      3 => "three",
      4 => "four",
      5 => "five",
      6 => "six"
    }
    @story.update("#{numbers[@chapter]}_choice".to_sym => params[:path],
                  "#{numbers[@chapter]}".to_sym => get_chapter_text(@story, @chapter))
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

    return story.one if chapter == 1

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
    session['names'] = SWNames.get_characters.join(",")
    passages = clean_passages([scraper.get_choices(1).first]).first
    passages = swap_names([passages]).first
    @story.update(one: passages)
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

    choices = swap_names(choices)

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

  def load_names
    session['names'].split(',')
  end

  def swap_names(passages)
    new_passages = []
    names = load_names
    puts names
    names_regex = /[A-Z]([a-z]+|\.)(?:\s+[A-Z]([a-z]+|\.))*(?:\s+[a-z][a-z\-]+){0,2}\s+[A-Z]([a-z]+|\.)/
    passages.each do |passage|
      new_passages << passage.gsub(names_regex, " #{names.sample}")
    end
    new_passages
  end
end
