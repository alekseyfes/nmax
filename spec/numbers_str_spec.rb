RSpec.describe NumbersStr do

  describe '#start_with_num?' do
    subject(:start_with_num) { described_class.start_with_num?(str) }

    context 'starts with number' do
      context do
        let(:str) { '123abc' }
        it { is_expected.to be_truthy }
      end
      context do
        let(:str) { '123abc123' }
        it { is_expected.to be_truthy }
      end
      context 'string is a number' do
        let(:str) { '123' }
        it { is_expected.to be_truthy }
      end
    end

    context 'does not start with a number' do
      context do
        let(:str) { 'abc' }
        it { is_expected.to be_falsey }
      end
      context do
        let(:str) { 'abc123abc' }
        it { is_expected.to be_falsey }
      end
      context do
        let(:str) { 'abc123' }
        it { is_expected.to be_falsey }
      end
    end

    context 'empty string' do
      context do
        let(:str) { '' }
        it { is_expected.to be_falsey }
      end
      context do
        let(:str) { nil }
        it { is_expected.to be_falsey }
      end
    end
  end

  describe '#end_with_num?' do
    subject(:end_with_num) { described_class.end_with_num?(str) }

    context 'ends with number' do
      context do
        let(:str) { 'abc123' }
        it { is_expected.to be_truthy }
      end
      context do
        let(:str) { '123abc123' }
        it { is_expected.to be_truthy }
      end
      context 'string is a number' do
        let(:str) { '123' }
        it { is_expected.to be_truthy }
      end
    end

    context 'does not end with a number' do
      context do
        let(:str) { 'abc' }
        it { is_expected.to be_falsey }
      end
      context do
        let(:str) { 'abc123abc' }
        it { is_expected.to be_falsey }
      end
      context do
        let(:str) { '123abc' }
        it { is_expected.to be_falsey }
      end
    end

    context 'empty string' do
      context do
        let(:str) { '' }
        it { is_expected.to be_falsey }
      end
      context do
        let(:str) { nil }
        it { is_expected.to be_falsey }
      end
    end
  end

  describe '#str_is_number?' do
    subject(:str_is_number) { described_class.str_is_number?(str) }

    context 'string is a number' do
      let(:str) { '123' }
      it { is_expected.to be_truthy }

      context 'start with zero' do
        context do
          let(:str) { '0123' }
          it { is_expected.to be_truthy }
        end
        context do
          let(:str) { '000123' }
          it { is_expected.to be_truthy }
        end
      end
    end

    context 'string is not a number' do
      context do
        let(:str) { 'abc' }
        it { is_expected.to be_falsey }
      end
      context do
        let(:str) { '123abc123' }
        it { is_expected.to be_falsey }
      end
      context do
        let(:str) { 'abc123abc' }
        it { is_expected.to be_falsey }
      end
      context do
        let(:str) { '123abc' }
        it { is_expected.to be_falsey }
      end
      context do
        let(:str) { 'abc123' }
        it { is_expected.to be_falsey }
      end
    end

    context 'empty string' do
      context do
        let(:str) { '' }
        it { is_expected.to be_falsey }
      end
      context do
        let(:str) { nil }
        it { is_expected.to be_falsey }
      end
    end
  end

  describe '#numbers_from_str' do
    subject(:numbers_from_str) { described_class.numbers_from_str(str) }

    context 'string contains a numbers' do
      context 'one number' do
        context do
          let(:str) { '123' }
          it { is_expected.to eq [123] }
        end
        context do
          let(:str) { '123abc' }
          it { is_expected.to eq [123] }
        end
        context do
          let(:str) { 'abc123' }
          it { is_expected.to eq [123] }
        end
        context do
          let(:str) { 'abc123abc' }
          it { is_expected.to eq [123] }
        end
        context do
          let(:str) { 'abc1abc' }
          it { is_expected.to eq [1] }
        end

        context 'start with zero' do
          context do
            let(:str) { '0123' }
            it { is_expected.to eq [123] }
          end
          context do
            let(:str) { '000123' }
            it { is_expected.to eq [123] }
          end
        end
      end

      context 'numbers' do
        context do
          let(:str) { '12aaa34' }
          it { is_expected.to eq [12, 34] }
        end
        context do
          let(:str) { 'aaa12aaa34aaa' }
          it { is_expected.to eq [12, 34] }
        end
        context 'identical numbers' do
          let(:str) { 'aaa12aaa12aaa12aaa34aaa34' }
          it { is_expected.to eq [12, 34] }
        end
      end
    end

    context 'no numbers' do
      let(:str) { 'abc' }
      it { is_expected.to eq [] }
    end

    context 'empty string' do
      context do
        let(:str) { '' }
        it { is_expected.to eq [] }
      end
      context do
        let(:str) { nil }
        it { is_expected.to eq [] }
      end
    end
  end
end
