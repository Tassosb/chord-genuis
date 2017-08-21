module Frettable
  extend ActiveSupport::Concern

  MAX_FRET_GAP = 3

  included do
    def notes
      @notes ||= frets.map.with_index do |fret, string|
        fretboard.note_at string: string, fret: fret
      end
    end

    def abstract_notes
      notes.map { |note| note&.abstract_note }
    end

    def has_no_duplicate_notes?
      pitch_set = Set.new
      notes.each do |note|
        return false if pitch_set.include?(note&.pitch)
        pitch_set.add(note&.pitch)
      end
      true
    end

    def triad?
      notes.count == 3
    end

    def movable?
      frets.compact.none?(&:zero?)
    end

    def within_reach?(new_fret)
      new_fret.zero? ||
        frets.compact.all? do |fret|
          fret.zero? || (new_fret - fret).abs < MAX_FRET_GAP
        end
    end
  end

  class_methods do
  end
end
