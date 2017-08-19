class IntervalGroup < ActiveHash::Base
  include ActiveHash::Associations
  include ActiveHash::Enum
  enum_accessor :name

  belongs_to :abstract_scale
  has_many :chord_shapes

  # belongs to an abstract Scale

  # has many intervals
    # e.g. 1 3 5

  # name / type
    # e.g. name: 'Major Triad'

  fields :name, :intervals, :abstract_scale

  self.data = [
    name: 'Major', intervals: [1, 3, 5], abstract_scale: AbstractScale::MAJOR
  ]

end
