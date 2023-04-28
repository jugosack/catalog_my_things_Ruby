require 'json'
require_relative '../classes/book'

class BookModel
  @file_path = '../JSON/books.json'

  def self.save(books)
    all_books = books.map do |book|
      { publisher: book.publisher, published_date: book.published_date, cover_state: book.cover_state,
        archived: book.archived }
    end
    File.write(@file_path, JSON.generate(all_books))
  end

  def self.fetch
    books = []
    if File.exist?(@file_path)
      JSON.parse(File.read(@file_path)).map do |book|
        books.push(Book.new(book['publisher'], book['published_date'], book['cover_state'], book['archived']))
      end
    end
    books
  end
end
