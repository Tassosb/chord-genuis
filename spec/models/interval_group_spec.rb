require "rails_helper"

RSpec.describe GuitarString do
  describe '#parent_scale' do
    let(:parent_scale) { interval_group.parent_scale }

    context 'major triad' do
      let(:interval_group) { IntervalGroup::MAJOR_TRIAD }

      it 'returns the major scale' do
        expect(parent_scale).to eq IntervalGroup::MAJOR_SCALE
      end
    end

    context 'minor triad' do
      let(:interval_group) { IntervalGroup::MINOR_TRIAD }

      it 'returns the minor scale' do
        expect(parent_scale).to eq IntervalGroup::MINOR_SCALE
      end
    end

    context 'sus4' do
      let(:interval_group) { IntervalGroup::SUSPENDED_4TH }

      it 'returns the major scale' do
        expect(parent_scale).to eq IntervalGroup::MAJOR_SCALE
      end
    end

    context 'sus2' do
      let(:interval_group) { IntervalGroup::SUSPENDED_2ND }

      it 'returns the minor scale' do
        expect(parent_scale).to eq IntervalGroup::MAJOR_SCALE
      end
    end

    context 'has no parent scale' do
      let(:interval_group) { IntervalGroup::MAJOR_SCALE }

      it 'returns the minor scale' do
        expect(parent_scale).to be_nil
      end
    end
  end
end
