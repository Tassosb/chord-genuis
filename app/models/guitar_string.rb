class GuitarString
  include ActiveModel::Model
  attr_accessor :open_note

  def [](fret_num)
    open_note.step(fret_num)
  end

  def locate_notes(abstract_notes)
    frets = []

    abstract_notes.each_with_index do |abstract_note|
      current_fret = open_note.abstract_note.distance_to(abstract_note)

      until current_fret > Constants::NUM_FRETS
        new_note = Note.new(
          abstract_note: abstract_note,
          pitch: open_note.pitch + current_fret
        )
        frets.push({note: new_note, fret: current_fret})
        current_fret += Constants::NUM_NOTES
      end
    end

    frets
  end
end
