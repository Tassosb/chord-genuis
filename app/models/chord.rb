class Chord
  include ActiveModel::Model
  include Frettable

  attr_accessor :interval_group, :frets, :root, :fretboard

  def self.build_from_shape(root, shape, fretboard = Fretboard.new)
    new(interval_group: shape.interval_group,
        fretboard: fretboard,
        frets: fretboard.chord_frets(root, shape),
        root: root)
  end

  def initialize(attributes = {})
    super
    @frets ||= DynamicChord.default_frets
  end

  def self.default_frets
    Array.new(Constants::NUM_STRINGS)
  end

  def add_fret(fret, string)
    @frets = @frets.dup
    @frets[string] = fret
    self
  end

  def root_string_number
    note_letters.index(root)
  end
end
