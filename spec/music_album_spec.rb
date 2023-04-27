require 'rspec'
require_relative '../classes/music_albums'
require_relative '../item'

RSpec.describe MusicAlbum do
  describe '#can_be_archived?' do
    context 'when published over 10 years ago and on Spotify' do
      it 'returns true' do
        album = MusicAlbum.new(true, 'January 1, 2000')
        expect(album.send(:can_be_archived?)).to be true
      end
    end

    context 'when published over 10 years ago but not on Spotify' do
      it 'returns false' do
        album = MusicAlbum.new(false, 'January 1, 2000')
        expect(album.send(:can_be_archived?)).to be false
      end
    end

    context 'when published less than 10 years ago and on Spotify' do
      it 'returns false' do
        album = MusicAlbum.new(true, 'January 1, 2022')
        expect(album.send(:can_be_archived?)).to be false
      end
    end

    context 'when published less than 10 years ago and not on Spotify' do
      it 'returns false' do
        album = MusicAlbum.new(false, 'January 1, 2022')
        expect(album.send(:can_be_archived?)).to be false
      end
    end
  end
end
