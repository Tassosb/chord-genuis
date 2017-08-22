class Tuning < ActiveHash::Base
  include ActiveHash::Enum

  fields :notes, :name
  enum_accessor :name

  self.data = [
    {name: 'Standard', notes: %w[E A D G B E], starting_octave: -2 }
  ]

  def lowest_note
    note_letter = NoteLetter.find_by(name: notes.first)
    Note.new(
      note_letter: note_letter,
      pitch: note_letter.relative_pitch * starting_octave
    )
  end
end
