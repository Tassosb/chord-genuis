class Fretboard
  include ActiveModel::Model
  attr_accessor :tuning

  def strings
    @strings ||= Fretboard.generate_strings(tuning)
  end

  def note_at(string: 0, fret: nil)
    return nil if fret.blank?
    strings[string][fret]
  end

  def find_chord_frets(chord)
    root_string = strings[chord.root_string_number]
    possible_root_frets = root_string.locate_note chord.root

    possible_root_frets.map do |root_fret|
      anchored_frets chord.shape, root_fret
    end.find { |frets| on_board? frets }
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
