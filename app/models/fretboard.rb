class Fretboard
  include ActiveModel::Model
  attr_accessor :tuning

  def strings
    @strings ||= Fretboard.generate_strings(tuning)
  end

  def [](pos)
    string_idx, fret_idx = pos
    strings[string_idx][fret_idx]
  end
  # has many strings

  # belongs_to a tuning
  # has many notes based on tuning, each note has a position

  # given a fret position, knows the note

  def locate_chord(chord)
    root_note = chord.root
    root_string = strings[chord.root_string_number]

    possible_root_frets = root_string.locate_note root_note

    frets = []
    possible_root_frets.each do |root_fret|
      anchored_frets = anchored_frets chord.shape, root_fret
      frets.push anchored_frets if on_board? anchored_frets
    end

    frets
  end

  private

  def anchored_frets(shape, anchor_fret)
    diff = anchor_fret - shape.fret_at_root
    shape.frets.map do |fret|
      fret && fret + diff
    end
  end

  def on_board?(frets)
    frets.compact.all? { |fret| fret.between? 0, Constants::NUM_FRETS }
  end

  def self.generate_strings(tuning)
    tuning.notes.map do |note_name|
      open_note = Note.find_by(name: note_name)
      GuitarString.new(open_note: open_note)
    end
  end
end
