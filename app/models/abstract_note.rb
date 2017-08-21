class AbstractNote < ActiveHash::Base
  include ActiveHash::Enum

  enum_accessor :name

  fields :name, :relative_pitch

  self.data = [
    {name: 'A', relative_pitch: 0},
    {name: 'A sharp', relative_pitch: 1},
    {name: 'B flat', relative_pitch: 1},
    {name: 'B', relative_pitch: 2},
    {name: 'C flat', relative_pitch: 2},
    {name: 'C', relative_pitch: 3},
    {name: 'B sharp', relative_pitch: 3},
    {name: 'C sharp', relative_pitch: 4},
    {name: 'D flat', relative_pitch: 4},
    {name: 'D', relative_pitch: 5},
    {name: 'D sharp', relative_pitch: 6},
    {name: 'E flat', relative_pitch: 6},
    {name: 'E', relative_pitch: 7},
    {name: 'F flat', relative_pitch: 7},
    {name: 'F', relative_pitch: 8},
    {name: 'E sharp', relative_pitch: 8},
    {name: 'F sharp', relative_pitch: 9},
    {name: 'G flat', relative_pitch: 9},
    {name: 'G', relative_pitch: 10},
    {name: 'G sharp', relative_pitch: 11},
    {name: 'A flat', relative_pitch: 11},
  ]

  def self.[](rel_pitch)
    AbstractNote.find_by(relative_pitch: rel_pitch)
  end

  def step(distance)
    next_relative_pitch = (relative_pitch + distance) % Constants::NUM_NOTES
    AbstractNote.find_by(relative_pitch: next_relative_pitch)
  end

  def distance_to(other_note)
    if other_note.relative_pitch < relative_pitch
      (Constants::NUM_NOTES - relative_pitch) + other_note.relative_pitch
    else
      other_note.relative_pitch - relative_pitch
    end
  end

  def ==(other_note)
    relative_pitch == other_note.relative_pitch
  end
end
