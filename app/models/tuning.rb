class Tuning < ActiveHash::Base
  include ActiveHash::Enum

  fields :notes, :name
  enum_accessor :name

  self.data = [
    {name: 'Standard', notes: %w[E A D G B E], starting_octave: -2 }
  ]

  def lowest_note
    abstract_note = AbstractNote.find_by(name: notes.first)
    Note.new(
      abstract_note: abstract_note,
      pitch: abstract_note.relative_pitch * starting_octave
    )
  end
end
