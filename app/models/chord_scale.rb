class ChordScale
  include ActiveModel::Model

  attr_accessor :scale

  delegate :note_letters, to: :scale

  def chord_interval_groups
    @chord_interval_groups ||= note_letters.map do |note_letter|
      ChordIntervalGroup.new(
        interval_group: IntervalGroup.within_scale(scale, note_letter),
        root_note_letter: note_letter
      )
    end
  end
end
