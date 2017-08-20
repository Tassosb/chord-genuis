class IntervalGroup < ActiveHash::Base
  include ActiveHash::Associations
  include ActiveHash::Enum
  enum_accessor :name

  belongs_to :abstract_scale

  has_many :chord_shapes

  fields :name, :intervals, :abstract_scale

  self.data = [
    { name: 'Major',
      intervals: [Interval::FIRST, Interval::THIRD, Interval::FIFTH],
      abstract_scale: AbstractScale::MAJOR,
    },
    {
      name: 'Minor',
      intervals: [Interval::FIRST, Interval::FLAT_THIRD, Interval::FIFTH],
      abstract_scale: AbstractScale::MINOR
    }
  ]

end
