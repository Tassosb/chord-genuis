class GuitarString
  include ActiveModel::Model
  attr_accessor :open_note, :number

  delegate :abstract_note, to: :open_note, prefix: true

  def [](fret_num)
    open_note.step(fret_num)
  end

  def locate_notes(notes)
    if notes.first.is_a? AbstractNote
      locate_abstract_notes(notes)
    else
      notes.map { |note| note.interval_between(open_note) }
    end
  end

  def locate_abstract_notes(abstract_notes)
    frets = []

    abstract_notes.each do |abstract_note|
      current_fret = open_note_abstract_note.distance_to(abstract_note)

      until current_fret > Constants::NUM_FRETS
        frets.push current_fret
        current_fret += Constants::NUM_NOTES
      end
    end

    frets
  end
end
