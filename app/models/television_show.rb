require 'csv'

class TelevisionShow
  GENRES = ["Action", "Mystery", "Drama", "Comedy", "Fantasy"]
  attr_reader :title, :network, :starting_year, :synopsis, :genre, :error
  def initialize(params={})
    @title = params["title"]
    @network = params["network"]
    @starting_year = params["starting_year"]
    @synopsis = params["synopsis"]
    @genre = params["genre"]
    @error =[]
  end

  def  errors
    unless (title.nil?) || (network.nil?) || (starting_year.nil?) || (synopsis.nil?) || (genre.nil?)
      if (title.empty?) || (network.empty?) || (starting_year.empty?) || (synopsis.empty?) || (genre.empty?)
        error << "Please fill in all required fields."
      elsif !unique_title
        error << "The show has already been added."
      end
    end
    error
   end


  def self.all
    tv_shows =[]
    CSV.foreach("television-shows.csv", headers: true) do |show|
      tv_shows << show
    end
    tv_shows.map { |show| TelevisionShow.new(show)}
  end

  def valid?
    !title.empty? &&
    !network.empty? &&
    !starting_year.empty? &&
    !synopsis.empty? &&
    !genre.empty? &&
    unique_title
  end

  def save
    if valid?
      CSV.open('television-shows.csv', 'a') do |file|
        file.puts([title, network, starting_year, synopsis, genre])
      end
      true
    else
      false
    end
  end

  def unique_title
    !TelevisionShow.all.any? {|show| show.title == title}
  end



end
