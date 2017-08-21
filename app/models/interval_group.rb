class IntervalGroup < ActiveHash::Base
  include ActiveHash::Associations
  include ActiveHash::Enum
  enum_accessor :name

  belongs_to :abstract_scale

  has_many :chord_shapes

  fields :name, :intervals, :abstract_scale

  self.data = [
    { name: 'Major',
      abbreviation: 'maj',
      intervals: [Interval::FIRST, Interval::THIRD, Interval::FIFTH],
      abstract_scale: AbstractScale::MAJOR,
    },
    {
      name: 'Minor',
      abbreviation: 'min',
      intervals: [Interval::FIRST, Interval::FLAT_THIRD, Interval::FIFTH],
      abstract_scale: AbstractScale::MINOR
    },
    {
      name: 'Suspended 4th',
      abbreviation: 'sus4',
      intervals: [Interval::FIRST, Interval::FOURTH, Interval::FIFTH],
      abstract_scale: AbstractScale::MAJOR
    },
    {
      name: 'Suspended 2nd',
      abbreviation: 'sus4',
      intervals: [Interval::FIRST, Interval::SECOND, Interval::FIFTH],
      abstract_scale: AbstractScale::MAJOR
    }
  ]

end
