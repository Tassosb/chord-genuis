class Fretboard
  include ActiveModel::Model
  attr_accessor :tuning
  attr_reader :strings

  def initialize(tuning: Tuning::STANDARD, **attributes)
    super
    @strings ||= Fretboard.generate_strings(tuning)
  end

  def note_at(string: 0, fret: nil)
    return nil if fret.blank?
    strings[string][fret]
  end

  def open_notes
    strings.map(&:open_note)
  end

  def frets_by_string_and_note(notes)
    strings.each_with_object({}) do |string, acc|
      acc[string] = string.locate_notes(notes)
    end
  end

  def find_chord_frets(chord)
    root_string = strings[chord.root_string_number]
    possible_root_frets = root_string.locate_notes([chord.root])
                                     .map { |note_fret| note_fret[:fret] }

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
    current_pitch = tuning.lowest_note.pitch
    current_abstract_note = tuning.lowest_note.abstract_note

    tuning.notes.map do |note_name|
      open_abstract_note = AbstractNote.find_by(name: note_name)
      current_pitch += current_abstract_note.distance_to(open_abstract_note)

      open_note = Note.new(
        abstract_note: open_abstract_note,
        pitch: current_pitch
      )

      current_abstract_note = open_abstract_note
      GuitarString.new(open_note: open_note)
    end
  end
end
