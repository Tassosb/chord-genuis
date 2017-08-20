class Chord
  include ActiveModel::Model

  attr_accessor :shape, :root, :fretboard

  # chord_shape => ChordShape<name: 'Major'>

  # this can be rendered

  def frets
    @frets ||= fretboard.find_chord_frets(self)
  end

  def notes
    @notes ||= frets.map.with_index do |fret, string|
      fretboard.note_at string: string, fret: fret
    end.compact
  end

  def root_string_number
    shape.root_string
  end

  class MissingFretsError < StandardError; end
end
