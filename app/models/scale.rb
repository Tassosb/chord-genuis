class Scale
  include ActiveModel::Model

  attr_accessor :interval_group, :root_note_letter

  delegate :intervals, to: :interval_group

  def note_letters
    root_note_letter.relative_note_letters intervals
  end

  def subset?(other_scale)
    (other_scale.note_letters - note_letters).empty?
  end
end
