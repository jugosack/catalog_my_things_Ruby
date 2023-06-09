require_relative '../item'

class Book < Item
  attr_accessor :publisher, :cover_state, :id

  def initialize(publisher, publish_date, cover_state = 'good', id = nil, archived: false)
    @id = id || Random.rand(1..1000)
    super(@id, publish_date, archived: archived)
    @publisher = publisher
    @cover_state = cover_state
  end

  private

  def can_be_archived?
    super && @cover_state == 'bad'
  end
end
