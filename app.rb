require 'json'
require 'date'
require_relative './classes/game'
require_relative './classes/author'
require_relative './classes/book'
require_relative './classes/label'
require_relative './classes/genre'
require_relative './classes/music_albums'
require_relative './model/label_model'
require_relative './model/book_model'
require_relative './load_data'
require 'pry'

class App # rubocop:disable Metrics/ClassLength
  attr_accessor :id, :books, :labels, :games, :authors, :music_albums, :genres

  puts
  puts "Welcome to Catalog of my things app!\n\n"
  def initialize
    @books = BookModel.fetch
    @labels = LabelModel.fetch
    @music_album = load_music_albums
    @genres = load_genres
    @games = []
    @authors = []

    loader = Loader.new
    loader.load_games(@games)
    loader.load_authors(@authors)
  end

  # Code to list all books
  def list_books
    puts 'All books'
    puts
    if @books.empty?
      puts 'No books available'
    else
      @books.each_with_index do |book, index|
        puts "#{index + 1}) Publisher: \"#{book.publisher}\", Published Date: #{book.publish_date},
        Cover State: #{book.cover_state}, Archived: #{book.archived}"
      end
    end
  end

  # Code to list all labels7
  def list_labels
    puts 'labels'
    puts
    if @labels.empty?
      puts 'No labels available'
    else
      @labels.each_with_index { |label, index| puts "#{index + 1}) Title: \"#{label.title}\", Color: #{label.color}" }
    end
  end

  # Code to list all music album
  def list_music_album
    puts 'music album'
    return puts 'No music albums found' if @music_album.empty?

    @music_album.each_with_index do |music_album, index|
      puts "#{index + 1}) Genre: #{music_album.genre.name}, On spotify: #{music_album.on_spotify}"
      puts "Publish date: #{music_album.publish_date}"
    end
  end

  # Code to list all genres
  def list_genres
    puts 'genres'
    return puts 'No genres found' if @genres.empty?

    @genres.each_with_index do |genre, index|
      puts "#{index + 1}) Name: #{genre.name}"
    end
  end

  # Code to list all games
  def list_games
    if @games.empty?
      puts 'There is no game added!'
    else
      puts 'All the games: '
      puts '----------------------------'
      @games.each_with_index do |game, index|
        print "[Game #{index + 1}]. Multiplayer : #{game['multiplayer']}, Publish Date :"
        puts " #{game['publish_date']}, Last Played Date : #{game['last_played_date']}"
        puts '----------------------------'
      end
    end
  end

  def list_authors
    puts 'All authors: '
    puts '----------------------------'
    if @authors.empty?
      puts 'There are no authors!'
    else
      puts 'Authors:'
      @authors.each_with_index do |author, index|
        puts "[Author #{index + 1}]. First Name : #{author['first_name']}, Last Name : #{author['last_name']} "
        puts '----------------------------'
      end
    end
  end

  def add_book
    puts 'add book'
    puts

    print 'Enter Publisher Name: '
    publisher = gets.chomp
    print 'Enter Published Date: '
    publish_date = gets.chomp
    print 'Enter Cover state (good/bad): (bad) for bad cover state or (good) for good cover state: '
    cover_state = gets.chomp
    puts 'Add label to book'
    print 'Enter label title: '
    label_title = gets.chomp
    print 'Enter label color: '
    label_color = gets.chomp
    label = Label.new label_title, label_color
    book = Book.new(publisher, publish_date, cover_state)
    book.add_label(label)
    @labels << label
    @books << book

    puts 'Book created successfully'
  end

  # Code to add music album
  def add_music_album
    puts 'add album'
    puts 'Available on spotify? [Y / N]'
    on_spotify = gets.chomp.downcase == 'y'
    puts 'Enter publish date in format (YYYY-MM-DD)'
    publish_date = Date.parse(gets.chomp)
    new_music_album = MusicAlbum.new(nil, on_spotify, publish_date)
    puts "Enter genre details\n"
    new_genre = add_genre
    new_music_album.add_genre(new_genre)
    @music_album.push(new_music_album)
    save_music_album(new_music_album)
    puts 'Music album created successfully'
  end

  def add_genre
    puts 'Enter name'
    name = gets.chomp
    new_genre = Genre.new(nil, name)
    @genres.push(new_genre)
    save_genre(new_genre)
    new_genre
  end

  # Code to add game
  def add_game
    puts 'Is it a multiplayer game? [Y/N]: '
    multiplayer = gets.chomp.to_s.downcase
    multiplayer = %w[y yes].include?(multiplayer)
    puts 'What is the publish date for the game [yyyy-mm-dd]: '
    publish_date = gets.chomp
    puts 'What is the last played date [yyyy-mm-dd]: '
    last_played_date = gets.chomp
    game = Game.new(id, publish_date, multiplayer, last_played_date)
    game_hash = {
      'publish_date' => publish_date,
      'multiplayer' => multiplayer,
      'last_played_date' => last_played_date
    }
    @games << game_hash
    author = add_author
    author.add_item(game)
    puts "The game created with #{author.first_name} author added successfully!"
  end

  def add_author
    print 'Enter the first name of the author: '
    first_name = gets.chomp
    print 'Enter the last name of the author: '
    last_name = gets.chomp
    author = Author.new(first_name, last_name)
    author_hash = {
      'first_name' => first_name,
      'last_name' => last_name
    }
    @authors << author_hash
    author
  end

  def exit_app
    # File.write('./JSON/genres.json', JSON.pretty_generate(@genres))
    File.write('./JSON/games.json', JSON.pretty_generate(@games))
    File.write('./JSON/authors.json', JSON.pretty_generate(@authors))
    puts 'Thank you for using this app!'
    # store books in json
    BookModel.save(@books)

    # store books in json
    LabelModel.save(@labels)

    exit
  end

  ######################### JSON methods #########################
  def load_music_albums
    # return unless File.exist?('./JSON/music_albums.json')
    music = []
    if File.exist?('./JSON/music_albums.json')
      music_albums_loaded = JSON.parse(File.read('./JSON/music_albums.json'))
      music_albums_loaded.each do |music_album|
        new_music_album = MusicAlbum.new(music_album['id'], music_album['on_spotify'], music_album['publish_date'])
        genres = load_genres
        new_genre = genres.select { |genre| genre.id == music_album['genre_id'] }[0]
        new_music_album.add_genre(new_genre)
        music << new_music_album
      end
    end
    music
  end

  def load_genres
    genres = []
    if File.exist?('./JSON/genres.json')
      genres_loaded = JSON.parse(File.read('./JSON/genres.json'))
      genres_loaded.each do |genre|
        new_genre = Genre.new(genre['id'], genre['name'])
        genres << new_genre
      end
    end
    genres
  end

  def save_music_album(music_album)
    new_music_album = { id: music_album.id, on_spotify: music_album.on_spotify, publish_date: music_album.publish_date,
                        genre_id: music_album.genre.id }
    if File.exist?('./JSON/music_albums.json')
      music_albums_loaded = JSON.parse(File.read('./JSON/music_albums.json'))
      music_albums_loaded << new_music_album
      File.write('./JSON/music_albums.json', JSON.pretty_generate(music_albums_loaded))
    else
      File.write('./JSON/music_albums.json', JSON.pretty_generate([new_music_album]))
    end
  end

  def save_genre(genre)
    new_genre = { id: genre.id, name: genre.name }
    if File.exist?('./JSON/genres.json')
      genres_loaded = JSON.parse(File.read('./JSON/genres.json'))
      genres_loaded << new_genre
      File.write('./JSON/genres.json', JSON.pretty_generate(genres_loaded))
    else
      File.write('./JSON/genres.json', JSON.pretty_generate([new_genre]))
    end
  end

  # private :add_genre
end
