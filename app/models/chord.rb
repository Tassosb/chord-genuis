class Chord
  include ActiveModel::Model

  attr_accessor :shape, :root, :fretboard

  # root => Note

  # chord_shape => ChordShape<name: 'Major'>

  # this can be rendered

  # maybe not persisted in database, but built in memory
  # from Chord shape and IntervalGroup

  def frets
    @frets ||= fretboard.generate_chord_frets(self)
    raise MissingFretsError.new('chord does not fit') unless @frets
    @frets
  end

  def root_string_number
    shape.root_string
  end

  class MissingFretsError < StandardError; end
end
