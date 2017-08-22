class GenericChordShape < ActiveHash::Base
  include ActiveHash::Associations
  include ActiveHash::Enum

  enum_accessor :name
  fields :frets, :root, :name

  belongs_to :interval_group

  self.data = [
    {
      name: 'Root 6 Major',
      frets: [0, 2, 2, 1, 0, 0],
      root_string_number: 0,
      interval_group: IntervalGroup::MAJOR_TRIAD
    },
    {
      name: 'Root 5 Major',
      frets: [nil, 0, 2, 2, 2, 0],
      root_string_number: 1,
      interval_group: IntervalGroup::MAJOR_TRIAD
    },
    {
      name: 'Root 6 Suspended 4th',
      frets: [0, 2, 2, 2, 0, 0],
      root_string_number: 0,
      interval_group: IntervalGroup::SUSPENDED_4TH
    },
    {
      name: 'Root 5 Suspended 4th',
      frets: [nil, 0, 2, 2, 3, 0],
      root_string_number: 1,
      interval_group: IntervalGroup::SUSPENDED_4TH
    },
    {
      name: 'Root 6 Suspended 2nd',
      frets: [0, 2, 4, nil, nil, nil],
      root_string_number: 0,
      interval_group: IntervalGroup::SUSPENDED_2ND
    },
    {
      name: 'Root 5 Suspended 2nd',
      frets: [nil, 0, 2, 2, 0, 0],
      root_string_number: 1,
      interval_group: IntervalGroup::SUSPENDED_2ND
    },
    {
      name: 'Root 6 Minor',
      frets: [0, 2, 2, 0, 0, 0],
      root_string_number: 0,
      interval_group: IntervalGroup::MINOR_TRIAD
    },
    {
      name: 'Root 5 Minor',
      frets: [nil, 0, 2, 2, 1, 0],
      root_string_number: 1,
      interval_group: IntervalGroup::MINOR_TRIAD
    }
  ]

  def fret_at_root
    frets[root_string_number]
  end
end
