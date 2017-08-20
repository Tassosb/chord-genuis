require "rails_helper"

RSpec.describe Chord do
  let(:fretboard) { Fretboard.new(tuning: Tuning::STANDARD) }
  let(:chord) { Chord.new(root: note, fretboard: fretboard, shape: shape) }

  describe '#notes' do
    context 'root 6 E major' do
      let(:shape) { ChordShape::ROOT_6_MAJOR }
      let(:note) { Note::E }

      it 'returns the notes in the chord by string' do
        expect(chord.notes).to eq(
          [Note::E, Note::B, Note::E, Note::G_SHARP, Note::B, Note::E]
        )
      end
    end

    context 'the chord has a nil fret' do
      let(:shape) { ChordShape::ROOT_5_MINOR }
      let(:note) { Note::A }

      it 'returns the notes in the chord without nil values' do
        expect(chord.notes).to eq(
          [Note::A, Note::E, Note::A, Note::C, Note::E]
        )
      end
    end
  end

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

    context 'Root 6 Minor Chords' do
      let(:shape) { ChordShape::ROOT_6_MINOR }

      context 'F minor' do
        let(:note) { Note::F }

        it 'returns the correct frets lowest on the fretboard' do
          expect(chord.frets).to eq(
            [1, 3, 3, 1, 1, 1]
          )
        end
      end

      context 'G minor' do
        let(:note) { Note::G }

        it 'returns the correct frets' do
          expect(chord.frets).to eq(
            [3, 5, 5, 3, 3, 3]
          )
        end
      end
    end

    context 'Root 5 Minor Chords' do
      let(:shape) { ChordShape::ROOT_5_MINOR }

      context 'B flat minor' do
        let(:note) { Note::B_FLAT }

        it 'returns the correct frets lowest on the fretboard' do
          expect(chord.frets).to eq(
            [nil, 1, 3, 3, 2, 1]
          )
        end
      end

      context 'C minor' do
        let(:note) { Note::C }

        it 'returns the correct frets' do
          expect(chord.frets).to eq(
            [nil, 3, 5, 5, 4, 3]
          )
        end
      end
    end
  end
end
