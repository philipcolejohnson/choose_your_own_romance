class StoriesController < ApplicationController
  def new
    @story = Story.new
    @story.save
    session['chapter'] = 0
    save_next_chapters
  end

  def edit
    @chapter = session['chapter'].to_i + 1
    @story = Story.find(params[:id])
    if @choices = save_next_chapters
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

  def save_next_chapters
    scraper = RomanceCrawler.new
    choices = scraper.get_choices(3)
    #session['choices'] = choices
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
