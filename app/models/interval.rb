class Interval < ActiveHash::Base
  include ActiveHash::Enum

  enum_accessor :key

  self.data = [
    {key: 'first', degree: 0},
    {key: 'flat second', degree: 1},
    {key: 'second', degree: 2},
    {key: 'flat third', degree: 3},
    {key: 'third', degree: 4},
    {key: 'fourth', degree: 5},
    {key: 'sharp fourth', degree: 6},
    {key: 'flat fifth', degree: 6},
    {key: 'fifth', degree: 7},
    {key: 'flat sixth', degree: 8},
    {key: 'sixth', degree: 9},
    {key: 'flat seventh', degree: 10},
    {key: 'seventh', degree: 11},
  ]

  def ==(other_interval)
    degree == other_interval.degree
  end
end
