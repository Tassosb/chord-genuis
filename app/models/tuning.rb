class Tuning < ActiveHash::Base
  include ActiveHash::Enum

  fields :notes, :name
  enum_accessor :name

  self.data = [
    {name: 'Standard', notes: %w[E A D G B E]}
  ]

  #
  # def initialize(root, string_distances)
  #   non_root_notes = string_distances.inject(root) do |curr_note, distance|
  #     curr_note.step(distance)
  #   end
  #
  #   @notes = [root, *non_root_notes]
  #
  #   if notes.length != Constants::NUM_STRINGS
  #     raise InvalidTuning, 'number of notes does not match number of strings'
  #   end
  # end
  #
  # def generate_strings(num_strings, num_frets)
  #   Array.new(num_strings) do
  #     GuitarString.new(num_frets)
  #   end
  # end
  #
  # class InvalidTuning < StandardError; end
end
