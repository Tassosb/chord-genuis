require "rails_helper"

RSpec.describe GuitarString do
  subject { GuitarString.new(open_note: open_note) }
  let(:open_note) do
    Note.new(
      note_letter: NoteLetter::E,
      pitch: -14
    )
  end

  describe '#[]' do
    it 'returns the note at the input fret' do
      expect(subject[3].pitch).to eq -11
      expect(subject[3].note_letter).to eq NoteLetter::G
    end

    context 'when wrapping around the alphabet' do
      it 'returns the correct note' do
        expect(subject[14].note_letter).to eq NoteLetter::F_SHARP
        expect(subject[14].pitch).to eq 0
      end
    end
  end

  describe '#locate_notes' do
    before { stub_const('Constants::NUM_FRETS', 24) }
    let(:notes) { [NoteLetter::C, NoteLetter::G, NoteLetter::E] }

    it 'returns the frets with the given notes' do
      frets = subject.locate_notes(notes)
      expect(frets).to contain_exactly(
        8, 3, 0, 20, 15, 12, 24
      )
    end
  end
end
