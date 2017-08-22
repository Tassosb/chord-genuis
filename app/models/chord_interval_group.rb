class ChordIntervalGroup
  include ActiveModel::Model

  attr_accessor :interval_group, :root_note_letter

  def voicings(fretboard = Fretboard.new)
    @voicings ||= ChordGenerationService.new(
      interval_group: interval_group,
      root_note_letter: root_note_letter,
      fretboard: fretboard
    ).perform
  end
end
