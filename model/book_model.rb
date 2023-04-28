require 'json'
require_relative '../classes/book'

class BookModel
  @file_path = './JSON/books.json'

  def self.save(books)
    exit if books.empty?
    all_books = books.map do |book|
      { id: book.id, publisher: book.publisher, publish_date: book.publish_date, cover_state: book.cover_state,
        archived: book.archived, label: book.label.id }
    end
    File.write(@file_path, JSON.pretty_generate(all_books))
  end

  def self.fetch
    books = []
    if File.exist?(@file_path)
      JSON.parse(File.read(@file_path)).map do |book|
        labels = LabelModel.fetch.find { |label| label.id == book['label'] }
        book = Book.new(book['publisher'], book['publish_date'], book['cover_state'], book['archived'])
        book.add_label(labels)
        books.push(book)
      end
    end
    books
  end
end
