require "rails_helper"

RSpec.describe Interval do
  subject { Interval::SHARP_FOURTH }

  describe '==' do
    context 'when the other interval has the same degree' do
      it 'returns true' do
        expect(subject).to eq(Interval::FLAT_FIFTH)
      end
    end

    context 'when the other interval has a different degree' do
      it 'returns false' do
        expect(subject).not_to eq Interval::FIFTH
      end
    end
  end
end
