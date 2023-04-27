require_relative '../item'

class MusicAlbum < Item
  attr_accessor :id, :on_spotify

  def initialize(id,on_spotify, publish_date = 'Uknown')
    super(id, publish_date)
    @on_spotify = on_spotify
  end

  private

  def can_be_archived?
    super && @on_spotify
  end
end
