class StoriesController < ApplicationController
  def new
    @story = Story.new
    @story.save
  end

  def edit
    @story = Story.find(params[:id])
    scraper = RomanceCrawler.new
    @choices = scraper.get_choices(3)
    p @choices[0]
  end

  def update
    @story = Story.find(params[:id])
    @story.update
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

end
