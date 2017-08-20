require "rails_helper"

RSpec.describe GuitarString do
  subject { GuitarString.new(open_note: open_note) }
  let(:open_note) { Note::E }

  describe '#[]' do
    it 'returns the note at the input fret' do
      expect(subject[3]).to eq Note::G
      expect(subject[11]).to eq Note::D_SHARP
    end

    context 'when wrapping around the alphabet' do
      it 'returns the correct note' do
        expect(subject[14]).to eq Note::F_SHARP
      end
    end
  end

  describe '#locate_note' do
    before { stub_const('Constants::NUM_FRETS', 24) }

    it 'returns the fret numbers with the given note' do
      expect(subject.locate_note Note::G).to contain_exactly 3, 15
    end
  end
end
