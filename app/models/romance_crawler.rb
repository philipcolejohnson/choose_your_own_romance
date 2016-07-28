require 'mechanize'

class RomanceCrawler
  
  def initialize
    @scraper = Mechanize.new
    @scraper.history_added = Proc.new { sleep 0.5 }
  end

  def scrape
      book = (1..10).to_a.sample
      chapter = (4..6).to_a.sample
      page = @scraper.get(make_url)
      chapters = page.links_with(text: "Read")[book].click
      story_page = chapters.links[chapter].click.links_with(text: " Next Page").first.click
      story_page.search("section#text").css("p").text
  end

  def get_choices(num_choices)
    stories = Array.new(num_choices)
    num_choices.times do |count|
      stories[count] = scrape
    end
    stories
  end

  def make_url
    base = 'http://www.publicbookshelf.com/romance/'
    base + (1..5).to_a.sample.to_s
  end
end
