class IntervalGroup < ActiveHash::Base
  include ActiveHash::Associations
  include ActiveHash::Enum
  enum_accessor :name

  has_many :chord_shapes

  fields :name, :intervals, :abbreviation

  self.data = [
    { name: 'Major Triad',
      abbreviation: 'maj',
      intervals: [Interval::FIRST, Interval::THIRD, Interval::FIFTH]
    },
    {
      name: 'Minor Triad',
      abbreviation: 'min',
      intervals: [Interval::FIRST, Interval::FLAT_THIRD, Interval::FIFTH]
    },
    {
      name: 'Diminished Triad',
      abbreviation: 'min',
      intervals: [Interval::FIRST, Interval::FLAT_THIRD, Interval::FLAT_FIFTH]
    },
    {
      name: 'Suspended 4th',
      abbreviation: 'sus4',
      intervals: [Interval::FIRST, Interval::FOURTH, Interval::FIFTH]
    },
    {
      name: 'Suspended 2nd',
      abbreviation: 'sus4',
      intervals: [Interval::FIRST, Interval::SECOND, Interval::FIFTH]
    },
    {
      name: 'Major Scale',
      intervals: [
        Interval::FIRST,
        Interval::SECOND,
        Interval::THIRD,
        Interval::FOURTH,
        Interval::FIFTH,
        Interval::SIXTH,
        Interval::SEVENTH
      ]
    },
    {
      name: 'Minor Scale',
      intervals: [
        Interval::FIRST,
        Interval::SECOND,
        Interval::FLAT_THIRD,
        Interval::FOURTH,
        Interval::FIFTH,
        Interval::FLAT_SIXTH,
        Interval::FLAT_SEVENTH
      ]
    }
  ]

  def self.within_scale(scale, note_letter)
    all.find do |interval_group|
      note_scale = Scale.new(
        interval_group: interval_group,
        root_note_letter: note_letter
      )
      scale.subset?(note_scale)
    end
  end

  def parent_scale
    IntervalGroup.all.find do |interval_group|
      next if interval_group == self
      (intervals - interval_group.intervals).empty?
    end
  end
end
