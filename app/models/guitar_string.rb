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

  def locate_notes(abstract_notes)
    frets = abstract_notes.map do |abs_note|
      new_note = Note.new(
        abstract_note: abs_note,
        pitch: open_note.pitch + open_note.abstract_note.distance_to(abs_note)
      )

      {note: new_note, fret: open_note.abstract_note.distance_to(abs_note)}
    end

    results = frets.dup

    frets.each_with_index do |fret, idx|
      current_fret = fret[:fret]

      until current_fret + Constants::NUM_NOTES > Constants::NUM_FRETS
        current_fret += Constants::NUM_NOTES
        new_note = Note.new(
          abstract_note: abstract_notes[idx],
          pitch: open_note.pitch + current_fret
        )
        results.push({note: new_note, fret: current_fret})
      end
    end

    results
  end
end
