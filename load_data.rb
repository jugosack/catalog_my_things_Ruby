class Loader
  def load_games(games)
    if File.exist?('./JSON/games.json')
      JSON.parse(File.read('./JSON/games.json')).each do |game|
        games << game
      end
    else
      games = []
    end
  end

  def load_authors(authors)
    if File.exist?('./JSON/authors.json')
      JSON.parse(File.read('./JSON/authors.json')).each do |author|
        authors << author
      end
    else
      authors = []
    end
  end
end
