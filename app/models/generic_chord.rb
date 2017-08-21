class GenericChord
  include ActiveModel::Model

  include Frettable

  attr_accessor :shape, :root, :fretboard

  def frets
    @frets ||= fretboard.find_chord_frets(self)
  end

  def root_string_number
    shape.root_string
  end
end
