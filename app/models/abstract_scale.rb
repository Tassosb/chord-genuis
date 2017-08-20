class AbstractScale < ActiveHash::Base
  include ActiveHash::Associations
  include ActiveHash::Enum

  enum_accessor :name

  has_many :interval_groups

  self.data = [
    {
      name: 'Major',
      degrees: [0, 2, 4, 5, 7, 9, 11]
    },
    {
      name: 'Minor',
      degrees: [0, 2, 3, 5, 7, 8, 10]
    }
  ]

  def intervals
    @intervals ||= Interval.where(degree: degrees)
  end

  def num_intervals
    degrees.length
  end

  def [](idx) # this might be nice
    intervals[idx]
  end
end
