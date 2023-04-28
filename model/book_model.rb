class BookModel
  def self.save(books)
    all_books = books.map { |book| { publisher: book.publisher, published_date: book.published_date } }
    File.write('./JSON/books.json', JSON.generate(all_books))
  end

  def self.books
    books = []
    if File.exist?('./JSON/books.json')
      JSON.parse(File.read('./JSON/books.json')).map do |book_hash|
        books.push(Book.new(book_hash['publisher'], book_hash['published_date']))
      end
    end
    books
  end
end
