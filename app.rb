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

class App
  attr_accessor :id, :books, :labels, :games, :authors, :music_albums, :genres

  puts
  puts "Welcome to Catalog of my things app!\n\n"
  def initialize
    @books = BookModel.fetch
    @labels = LabelModel.fetch
    @music_album = []
    @genres = []
    @games = []
    @authors = []
  end

  # Code to list all books
  def list_books
    puts 'books'
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

  # Code to list all labels
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
    puts 'games'
    puts
  end

  # Code to list all authors
  def list_authors
    puts 'authors'
    puts
  end

  # Code to add book
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
    puts 'add game'
    puts
  end

  # exit function
  def exit_app
    puts 'Thank you for using this app!'
    # store books in json
    BookModel.save(@books)

    # store books in json
    LabelModel.save(@labels)

    exit
  end
<<<<<<< HEAD

  ######################### JSON methods #########################
  def load_music_albums
    return unless File.exist?('./JSON/music_albums.json')

    music_albums_loaded = JSON.parse(File.read('./JSON/music_albums.json'))
    music_albums_loaded.each do |music_album|
      new_music_album = MusicAlbum.new(music_album['id'], music_album['on_spotify'], music_album['publish_date'])
      new_genre = @genres.select { |genre| genre.id == music_album['genre_id'] }[0]
      new_music_album.add_genre(new_genre)
      @music_albums << new_music_album
    end
  end

  def load_genres
    return unless File.exist?('./JSON/genres.json')

    genres_loaded = JSON.parse(File.read('./JSON/genres.json'))
    genres_loaded.each do |genre|
      new_genre = Genre.new(genre['id'], genre['name'])
      @genres << new_genre
    end
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

  private :add_genre
=======
>>>>>>> 5e8fb74 (Fixed Linters)
end
