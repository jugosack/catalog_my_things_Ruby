require_relative '../classes/book'

describe Book do
  before :each do
    @book = Book.new 'Publisher', '2010-10-10', 'good'
  end

  context '#new' do
    it 'returns a book object' do
      expect(@book).to be_an_instance_of Book
    end
  end

  describe '#can_be_archived?' do
    context 'when published over 10 years ago and cover_state is good' do
      it 'returns false' do
        expect(@book.send(:can_be_archived?)).to be false
      end
    end

    context 'when published over 10 years ago and cover_state is bad' do
      it 'returns true' do
        @book.cover_state = 'bad'
        expect(@book.send(:can_be_archived?)).to be true
      end
    end

    context 'when published date is less than 10 years ago' do
      it 'returns false' do
        book = Book.new('Publisher', 'January 1, 2022')
        expect(book.send(:can_be_archived?)).to be false
      end
    end
  end
end
