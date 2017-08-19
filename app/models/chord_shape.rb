class ChordShape < ActiveHash::Base
  include ActiveHash::Associations
  include ActiveHash::Enum

  enum_accessor :name
  fields :frets, :root, :name

  belongs_to :interval_group

  self.data = [
    {
      name: 'Root 6 Major',
      frets: [0, 2, 2, 1, 0, 0],
      root_string: 0,
      interval_group: IntervalGroup::MAJOR
    },
    {
      name: 'Root 5 Major',
      frets: [nil, 0, 2, 2, 2, 0],
      root_string: 1,
      interval_group: IntervalGroup::MAJOR
    }
  ]

  def fret_at_root
    frets[root_string]
  end

  # frets => [[1,0], [2,0], [3,1], [4,2], [5,2], [6,0]]

  # root => [1,0]

  # validate number of frets, within number of strings

  # belongs to an Interval Group
    #e.g. IntervalGroup<intervals: 1, 3, 5, name: 'Major'>
  # delegate :name, to: IntervalGroup
end
