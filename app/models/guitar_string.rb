class GuitarString
  include ActiveModel::Model
  attr_accessor :open_note, :number

  delegate :note_letter, to: :open_note, prefix: true

  def [](fret_num)
    open_note.step(fret_num)
  end

  def locate_notes(notes)
    if notes.first.is_a? NoteLetter
      locate_note_letters(notes)
    else
      notes.map { |note| note.interval_between(open_note) }
    end
  end

  def locate_note_letters(note_letters)
    frets = []

    note_letters.each do |note_letter|
      current_fret = open_note_note_letter.distance_to(note_letter)

      until current_fret > Constants::NUM_FRETS
        frets.push current_fret
        current_fret += Constants::NUM_NOTES
      end
    end

    frets
  end
end
