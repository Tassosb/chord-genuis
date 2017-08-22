class ChordGenerationService
  attr_reader :interval_group,
              :fretboard,
              :min_chord_notes,
              :root_note_letter

  DEFAULTS = {
    min_chord_notes: 3
  }

  def initialize(params)
    params = DEFAULTS.merge(params)

    @interval_group = params[:interval_group]
    @fretboard = params[:fretboard]
    @min_chord_notes = params[:min_chord_notes] || MIN_CHORD_NOTES
    @root_note_letter = params[:root_note_letter]
  end

  def perform
    frets_by_string = fretboard.frets_by_string(note_letters)

    chords = []
    fretboard.strings.each do |string|
      frets = frets_by_string[string]

      if string.number < 3
        new_chords = frets.map do |fret|
          new_chord = DynamicChord.new(
            root: root_note_letter,
            interval_group: interval_group,
            fretboard: fretboard
          )
          new_chord.add_fret(fret, string.number)
        end
      else
        new_chords = []
      end

      chords.each do |chord|
        frets_within_reach = frets.select { |f| chord.within_reach?(f) }

        frets_within_reach.each do |fret|
          new_chords.push(chord.dup.add_fret(fret, string.number))
        end
      end

      chords.concat(new_chords)
    end

    chords.select do |chord|
      (note_letters - chord.note_letters).empty? &&
      chord.has_no_duplicate_notes? &&
      chord.notes.count >= min_chord_notes
    end.sort_by { |chord| chord.notes.count * -1 }
  end

  private

  def note_letters
    @note_letters ||= root_note_letter.relative_note_letters intervals
  end

  def intervals
    interval_group.intervals
  end
end
