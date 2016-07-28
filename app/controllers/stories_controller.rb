class StoriesController < ApplicationController
  def new
    @story = Story.new
    @story.save
    session['chapter'] = 0
    save_next_chapters(@story, 1)
  end

  def edit
    @chapter = session['chapter'].to_i + 1
    @story = Story.find(params[:id])
    if @choices = save_next_chapters(@story, @chapter + 1)
      @words = get_choice_words(@choices)
      @choices = clean_passages(@choices)
    else
      flash.now[:error] = "Something went wrong :("
      render :index
    end
  end

  def update
    @story = Story.find(params[:id])
    @story.update
    next_chapter
    redirect_to :edit
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

    story.update("#{numbers[chapter]}_a".to_sym => choices[0], "#{numbers[chapter]}_b".to_sym => choices[1], "#{numbers[chapter]}_c".to_sym => choices[2])

    choices
  end

  def load_next_chapters
    #session['choices']
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
