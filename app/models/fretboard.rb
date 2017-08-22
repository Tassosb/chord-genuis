class Fretboard
  include ActiveModel::Model
  attr_accessor :tuning
  attr_reader :strings

  def initialize(tuning: Tuning::STANDARD, **attributes)
    super
    @strings ||= Fretboard.generate_strings(tuning)
  end

  def note_at(string, fret)
    strings[string][fret]
  end

  def open_notes
    strings.map(&:open_note)
  end

  def frets_by_string(note_letters)
    strings.each_with_object({}) do |string, acc|
      acc[string] = string.locate_notes(note_letters)
    end
  end

  def chord_frets(root, shape)
    root_string_number = strings[shape.root_string_number]
    possible_root_frets = root_string_number.locate_notes([root])

    possible_root_frets.each do |root_fret|
      frets = anchored_frets shape, root_fret
      return frets if on_board? frets
    end

    nil
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
    current_pitch = tuning.lowest_note.pitch
    current_note_letter = tuning.lowest_note.note_letter

    tuning.notes.map.with_index do |note_name, num|
      open_note_letter = NoteLetter.find_by(name: note_name)
      current_pitch += current_note_letter.distance_to(open_note_letter)

      open_note = Note.new(
        note_letter: open_note_letter,
        pitch: current_pitch
      )

      current_note_letter = open_note_letter
      GuitarString.new(open_note: open_note, number: num)
    end
  end
end
