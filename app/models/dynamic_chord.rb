class DynamicChord
  include ActiveModel::Model

  MAX_FRET_GAP = 3

  attr_accessor :interval_group, :frets, :root
  attr_reader :fretboard

  def initialize(frets: Array.new(Constants::NUM_STRINGS), **attrs)
    super
    @fretboard ||= Fretboard.new
  end

  def self.generate(root, interval_group, min_notes = 3)
    abstract_notes = interval_group.intervals.map do |interval|
      root.step interval.degree
    end

    fretboard = Fretboard.new
    strings = fretboard.strings
    note_frets_by_string = fretboard.frets_by_string_and_note(abstract_notes)

    chords = []

    strings.each_with_index do |string, num_string|
      frets = note_frets_by_string[string].map { |nf| nf[:fret] }

      if num_string < 3
        new_chords = frets.map do |fret|
          new_chord = DynamicChord.new(root: root)
          new_chord.add_fret(fret, num_string)
        end
      else
        new_chords = []
      end

      chords.each do |chord|
        frets_within_reach = frets.select { |f| chord.within_reach?(f) }

        frets_within_reach.each do |fret|
          new_chords.push(chord.dup.add_fret(fret, num_string))
        end
      end

      chords.concat(new_chords)
    end

    chords.select do |chord|
      (abstract_notes - chord.abstract_notes).empty? &&
      chord.has_no_duplicate_notes? && chord.notes.count >= min_notes
    end.sort_by { |chord| chord.notes.count * -1 }
  end

  def has_no_duplicate_notes?
    pitch_set = Set.new
    notes.each do |note|
      return false if pitch_set.include?(note.pitch)
      pitch_set.add(note.pitch)
    end
    true
  end

  def notes
    @notes ||= frets.map.with_index do |fret, string|
      fretboard.note_at string: string, fret: fret
    end.compact
  end

  def abstract_notes
    notes.map(&:abstract_note)
  end

  def within_reach?(new_fret)
    new_fret.zero? ||
      frets.compact.all? do |fret|
        fret.zero? || (new_fret - fret).abs < MAX_FRET_GAP
      end
  end

  def add_fret(fret, string)
    @frets = @frets.dup
    @frets[string] = fret
    self
  end

  def triad?
    notes.count == 3
  end
end
