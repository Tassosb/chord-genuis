class Note
  include ActiveModel::Model

  attr_accessor :pitch, :abstract_note

  delegate :relative_pitch, to: :abstract_note

  def interval_between(other_note)
    (pitch - other_note.pitch).abs
  end

  def step(distance)
    next_relative_pitch = (relative_pitch + distance) % Constants::NUM_NOTES

    Note.new(
      abstract_note: AbstractNote[next_relative_pitch],
      pitch: pitch + distance
    )
  end

  def ==(other_note)
    return false unless other_note.is_a? Note
    pitch == other_note.pitch
  end
end
