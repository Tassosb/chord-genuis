require "rails_helper"

RSpec.describe Chord do
  let(:fretboard) { Fretboard.new(tuning: Tuning::STANDARD) }
  let(:chord) { Chord.new(root: note, fretboard: fretboard, shape: shape) }

  describe '#frets' do
    context 'Root 6 Major Chords' do
      let(:shape) { ChordShape::ROOT_6_MAJOR }

      context 'root 6 A major' do
        let(:note) { Note::A }

        it 'returns the correct frets' do
          expect(chord.frets).to eq(
            [5, 7, 7, 6, 5, 5]
          )
        end
      end

      context 'root 6 G major' do
        let(:note) { Note::G }

        it 'returns the correct frets' do
          expect(chord.frets).to eq(
            [3, 5, 5, 4, 3, 3]
          )
        end
      end
    end

    context 'Root 5 Major Chords' do
      let(:shape) { ChordShape::ROOT_5_MAJOR }

      context 'root 5 D major' do
        let(:note) { Note::D }

        it 'returns the correct frets' do
          expect(chord.frets).to eq(
            [nil, 5, 7, 7, 7, 5]
          )
        end
      end

      context 'root 5 F major' do
        let(:note) { Note::C }

        it 'returns the correct frets' do
          expect(chord.frets).to eq(
            [nil, 3, 5, 5, 5, 3]
          )
        end
      end
    end

    context 'when the chord shape does not fit' do
      let(:shape) { ChordShape.new(root_string: 0, frets: [30, 5, 1, 6, nil, 2]) }
      let(:note) { Note::C }

      it 'raises' do
        expect { chord.frets }.to raise_error Chord::MissingFretsError
      end
    end
  end
end
