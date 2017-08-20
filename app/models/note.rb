class Note < ActiveHash::Base
  include ActiveHash::Enum

  enum_accessor :name

  fields :name, :order

  self.data = [
    {name: 'A', order: 0},
    {name: 'A sharp', order: 1},
    {name: 'B flat', order: 1},
    {name: 'B', order: 2},
    {name: 'C flat', order: 2},
    {name: 'C', order: 3},
    {name: 'B sharp', order: 3},
    {name: 'C sharp', order: 4},
    {name: 'D flat', order: 4},
    {name: 'D', order: 5},
    {name: 'D sharp', order: 6},
    {name: 'E flat', order: 6},
    {name: 'E', order: 7},
    {name: 'F flat', order: 7},
    {name: 'F', order: 8},
    {name: 'E sharp', order: 8},
    {name: 'F sharp', order: 9},
    {name: 'G flat', order: 9},
    {name: 'G', order: 10},
    {name: 'G sharp', order: 11},
    {name: 'A flat', order: 11},
  ]

  def step(distance)
    next_order = (order + distance) % Constants::NUM_NOTES
    Note.find_by(order: next_order)
  end

  def distance_to(other_note)
    if other_note.order < order
      (Constants::NUM_NOTES - order) + other_note.order
    else
      other_note.order - order
    end
  end

  def ==(other_note)
    order == other_note.order
  end

  # def initialize(value, octave)
  #   @value = value
  #   @octave = octave
  # end
  #
  # def step(distance)
  #   self.value += distance
  #
  #   if value >= Constants::NUM_NOTES
  #     self.octave += 1
  #     self.value %= Constants::NUM_NOTES
  #   end
  # end
  #
  # def name
  #
  # end
end
