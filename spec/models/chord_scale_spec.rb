require "rails_helper"

RSpec.describe ChordScale do
  subject { ChordScale.new(scale: scale) }

  let(:scale) do
    Scale.new(
      interval_group: interval_group,
      root_note_letter: root_note_letter
    )
  end

  describe '#chord_interval_groups' do
    let(:chord_interval_groups) { subject.chord_interval_groups }

    context 'C major chord scale' do
      let(:root_note_letter) { NoteLetter::C }
      let(:interval_group) { IntervalGroup::MAJOR_SCALE }

      it 'returns the correct chord interval groups' do
        expect(chord_interval_groups.map(&:interval_group)).to eq(
          [
            IntervalGroup::MAJOR_TRIAD,
            IntervalGroup::MINOR_TRIAD,
            IntervalGroup::MINOR_TRIAD,
            IntervalGroup::MAJOR_TRIAD,
            IntervalGroup::MAJOR_TRIAD,
            IntervalGroup::MINOR_TRIAD,
            IntervalGroup::DIMINISHED_TRIAD
          ]
        )
      end
    end

    context 'E minor chord scale' do
      let(:root_note_letter) { NoteLetter::E }
      let(:interval_group) { IntervalGroup::MINOR_SCALE }

      it 'returns the correct chord interval groups' do
        expect(chord_interval_groups.map(&:interval_group)).to eq(
          [
            IntervalGroup::MINOR_TRIAD,
            IntervalGroup::DIMINISHED_TRIAD,
            IntervalGroup::MAJOR_TRIAD,
            IntervalGroup::MINOR_TRIAD,
            IntervalGroup::MINOR_TRIAD,
            IntervalGroup::MAJOR_TRIAD,
            IntervalGroup::MAJOR_TRIAD
          ]
        )
      end
    end
  end
end
