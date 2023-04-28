class BookModel
  def self.save(books)
    all_books = books.map { |book| { publisher: book.publisher, published_date: book.published_date, cover_state: book.cover_state, archived: book.archived } }
    File.write('./JSON/books.json', JSON.generate(all_books))
  end

  def self.fetch
    books = []
    if File.exist?('./JSON/books.json')
      JSON.parse(File.read('./JSON/books.json')).map do |book_hash|
        books.push(Book.new(book_hash['publisher'], book_hash['published_date'],book_hash['cover_state'],book_hash['archived']))
      end
    end
    books
  end
end
