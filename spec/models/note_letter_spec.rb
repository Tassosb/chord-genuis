require "rails_helper"

RSpec.describe NoteLetter do
  subject { NoteLetter::A }

  describe '#step' do
    it 'returns the note ahead by the input number of steps' do
      expect(subject.step 2).to eq NoteLetter::B
    end

    context 'when wrapping around the note alphabet' do
      it 'returns the correct note' do
        expect(subject.step 14).to eq(NoteLetter::B)
      end
    end
  end

  describe '#distance_to' do
    it 'returns the distance to the other note' do
      expect(subject.distance_to NoteLetter::B).to eq(2)
    end

    context 'when the other note is behind the subject note in the alphabet' do
      subject { NoteLetter::E }

      it 'returns the distance to the other note, wrapping around the alphabet' do
        expect(subject.distance_to NoteLetter::C).to eq 8
      end
    end

    context 'when the other note has the same order' do
      it 'returns 0' do
        expect(subject.distance_to NoteLetter::A).to be_zero
      end
    end
  end

  describe '#==' do
    subject { NoteLetter::G_SHARP }

    context 'when the other note has the same order' do
      it 'returns true' do
        expect(subject).to eq NoteLetter::A_FLAT
      end
    end

    context 'when the other note has a different order' do
      it 'returns false' do
        expect(subject).not_to eq NoteLetter::A
      end
    end
  end
end
