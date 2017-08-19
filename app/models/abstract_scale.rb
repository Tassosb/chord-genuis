class AbstractScale < ActiveHash::Base
  include ActiveHash::Associations
  include ActiveHash::Enum

  enum_accessor :name

  has_many :interval_groups

  # has many degrees, e.g. 1, 2, 3, 4, 5, 6, 7
  # num_degrees

  #example: Major Scale
  # @name => 'Major'
  # @degrees.map(&:values) => [1, 3, 5, 6, 8, 10, 11]
    # this correspond to W W H W W W H steps

  self.data = [
    name: 'Major', degrees: [0, 2, 4, 5, 7, 9, 10]
  ]

  def num_degrees
    degrees.length
  end

  def [](idx) # this might be nice
    degrees[idx]
  end
end
