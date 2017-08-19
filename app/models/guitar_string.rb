class GuitarString
  include ActiveModel::Model
  # root => Note
  attr_accessor :open_note

  # knows number of frets

  # given a fret, returns the note

  def [](fret_num)
    open_note.step(fret_num)
  end

  def locate_note(note)
    frets = [open_note.distance_to(note)]
    until frets.last > Constants::NUM_STRINGS
      frets.push(frets.last + Constants::NUM_NOTES)
    end
    frets
  end
end
