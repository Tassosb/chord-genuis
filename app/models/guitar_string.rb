class GuitarString
  include ActiveModel::Model
  attr_accessor :open_note

  def [](fret_num)
    open_note.step(fret_num)
  end

  def locate_note(note)
    frets = [open_note.distance_to(note)]
    until frets.last + Constants::NUM_NOTES > Constants::NUM_FRETS
      frets.push(frets.last + Constants::NUM_NOTES)
    end
    frets
  end
end
