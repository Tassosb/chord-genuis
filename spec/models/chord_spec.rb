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
          expect(chord.frets).to contain_exactly(
            [5, 7, 7, 6, 5, 5], [17, 19, 19, 18, 17, 17]
          )
        end
      end

      context 'root 6 G major' do
        let(:note) { Note::G }

        it 'returns the correct frets' do
          expect(chord.frets).to contain_exactly(
            [3, 5, 5, 4, 3, 3], [15, 17, 17, 16, 15, 15]
          )
        end
      end
    end

    context 'Root 5 Major Chords' do
      let(:shape) { ChordShape::ROOT_5_MAJOR }

      context 'root 5 D major' do
        let(:note) { Note::D }

        it 'returns the correct frets' do
          expect(chord.frets).to contain_exactly(
            [nil, 5, 7, 7, 7, 5], [nil, 17, 19, 19, 19, 17]
          )
        end
      end

      context 'root 5 F major' do
        let(:note) { Note::C }

        it 'returns the correct frets' do
          expect(chord.frets).to contain_exactly(
            [nil, 3, 5, 5, 5, 3], [nil, 15, 17, 17, 17, 15]
          )
        end
      end
    end
  end
end
