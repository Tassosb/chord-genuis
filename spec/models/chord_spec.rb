require "rails_helper"

RSpec.describe Chord do
  let(:fretboard) { Fretboard.new(tuning: Tuning::STANDARD) }
  let(:chord) do
    Chord.build_from_shape(note, shape, fretboard)
  end

  describe '#note_letters' do
    context 'root 6 E major' do
      let(:shape) { GenericChordShape::ROOT_6_MAJOR }
      let(:note) { NoteLetter::E }

      it 'returns the notes in the chord by string' do
        expect(chord.note_letters).to eq(
          [
            NoteLetter::E,
            NoteLetter::B,
            NoteLetter::E,
            NoteLetter::G_SHARP,
            NoteLetter::B,
            NoteLetter::E
          ]
        )
      end
    end

    context 'the chord has a nil fret' do
      let(:shape) { GenericChordShape::ROOT_5_MINOR }
      let(:note) { NoteLetter::A }

      it 'returns the notes in the chord with nil values' do
        expect(chord.note_letters).to eq(
          [
            nil,
            NoteLetter::A,
            NoteLetter::E,
            NoteLetter::A,
            NoteLetter::C,
            NoteLetter::E
          ]
         )
      end
    end
  end

  describe '#frets' do
    context 'Root 6 Major Chords' do
      let(:shape) { GenericChordShape::ROOT_6_MAJOR }

      context 'root 6 A major' do
        let(:note) { NoteLetter::A }

        it 'returns the correct frets' do
          expect(chord.frets).to eq(
            [5, 7, 7, 6, 5, 5]
          )
        end
      end

      context 'root 6 G major' do
        let(:note) { NoteLetter::G }

        it 'returns the correct frets' do
          expect(chord.frets).to eq(
            [3, 5, 5, 4, 3, 3]
          )
        end
      end
    end

    context 'Root 5 Major Chords' do
      let(:shape) { GenericChordShape::ROOT_5_MAJOR }

      context 'root 5 D major' do
        let(:note) { NoteLetter::D }

        it 'returns the correct frets' do
          expect(chord.frets).to eq(
            [nil, 5, 7, 7, 7, 5]
          )
        end
      end

      context 'root 5 F major' do
        let(:note) { NoteLetter::C }

        it 'returns the correct frets' do
          expect(chord.frets).to eq(
            [nil, 3, 5, 5, 5, 3]
          )
        end
      end
    end

    context 'Root 6 Minor Chords' do
      let(:shape) { GenericChordShape::ROOT_6_MINOR }

      context 'F minor' do
        let(:note) { NoteLetter::F }

        it 'returns the correct frets lowest on the fretboard' do
          expect(chord.frets).to eq(
            [1, 3, 3, 1, 1, 1]
          )
        end
      end

      context 'G minor' do
        let(:note) { NoteLetter::G }

        it 'returns the correct frets' do
          expect(chord.frets).to eq(
            [3, 5, 5, 3, 3, 3]
          )
        end
      end
    end

    context 'Root 5 Minor Chords' do
      let(:shape) { GenericChordShape::ROOT_5_MINOR }

      context 'B flat minor' do
        let(:note) { NoteLetter::B_FLAT }

        it 'returns the correct frets lowest on the fretboard' do
          expect(chord.frets).to eq(
            [nil, 1, 3, 3, 2, 1]
          )
        end
      end

      context 'C minor' do
        let(:note) { NoteLetter::C }

        it 'returns the correct frets' do
          expect(chord.frets).to eq(
            [nil, 3, 5, 5, 4, 3]
          )
        end
      end
    end

    context 'Root 6 Suspended 4th Chords' do
      let(:shape) { GenericChordShape::ROOT_6_SUSPENDED_4TH }

      context 'Dsus4' do
        let(:note) { NoteLetter::D }

        it 'returns the correct frets lowest on the fretboard' do
          expect(chord.frets).to eq(
            [10, 12, 12, 12, 10, 10]
          )
        end
      end
    end

    context 'Root 5 Suspended 4th Chords' do
      let(:shape) { GenericChordShape::ROOT_5_SUSPENDED_4TH }

      context 'Csus4' do
        let(:note) { NoteLetter::C }

        it 'returns the correct frets lowest on the fretboard' do
          expect(chord.frets).to eq(
            [nil, 3, 5, 5, 6, 3]
          )
        end
      end
    end
  end
end
