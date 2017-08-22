require "rails_helper"

RSpec.describe ChordIntervalGroup do
  subject do
    ChordIntervalGroup.new(
      interval_group: interval_group,
      root_note_letter: root_note_letter
    )
  end

  let(:interval_group) { IntervalGroup::MAJOR_TRIAD }
  let(:root_note_letter) { NoteLetter::G }

  describe '#voicings' do
    it 'returns a collection of chords' do
      expect(subject.voicings.map(&:class).uniq).to eq [Chord]
    end
  end
end
