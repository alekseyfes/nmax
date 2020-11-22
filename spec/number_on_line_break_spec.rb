RSpec.describe NumberOnLineBreak do

  describe '#number_on_line_break?' do
    subject(:number_on_line_break) { described_class.number_on_line_break?(first, second) }

    context 'number in line break' do
      context do
        let(:first) { 'abc1' }
        let(:second) { '2abc' }
        it { is_expected.to be_truthy }
      end
      context 'it is numbers' do
        let(:first) { '123' }
        let(:second) { '456' }
        it { is_expected.to be_truthy }
      end
    end

    context 'number not in line break' do
      context do
        let(:first) { 'abc' }
        let(:second) { 'def' }
        it { is_expected.to be_falsey }
      end
      context do
        let(:first) { 'abc123' }
        let(:second) { 'def' }
        it { is_expected.to be_falsey }
      end
      context do
        let(:first) { 'abc' }
        let(:second) { '123def' }
        it { is_expected.to be_falsey }
      end
      context do
        let(:first) { '123abc' }
        let(:second) { 'def456' }
        it { is_expected.to be_falsey }
      end
    end

    context 'empty arguments' do
      context do
        let(:first) { '' }
        let(:second) { '' }
        it { is_expected.to be_falsey }
      end
      context do
        let(:first) { nil }
        let(:second) { nil }
        it { is_expected.to be_falsey }
      end
    end
  end

  describe '#without_number_on_br' do
    subject(:without_number_on_br) { described_class.without_number_on_br(strings) }

    context 'one string' do
      context do
        let(:strings) { ['abc'] }
        let(:result) { ['abc'] }
        it { is_expected.to eq(result) }
      end
      context do
        let(:strings) { ['123'] }
        let(:result) { ['123'] }
        it { is_expected.to eq(result) }
      end
    end

    context 'number in line break' do
      context do
        let(:strings) { ['aaa123', '456bbb'] }
        let(:result) { ['aaa123456', 'bbb'] }
        it { is_expected.to eq(result) }
      end

      context do
        let(:strings) { ['aaa123', '456bbb', 'ccc'] }
        let(:result) { ['aaa123456', 'bbb', 'ccc'] }
        it { is_expected.to eq(result) }
      end

      context 'one string is a number' do
        let(:strings) { ['aaa111', '222', 'ccc'] }
        let(:result) { ['aaa111222', 'ccc'] }
        it { is_expected.to eq(result) }
      end

      context 'double line break' do
        context do
          let(:strings) { ['aaa', 'bbb111', '222', '333ddd', 'eee'] }
          let(:result) { ['aaa', 'bbb111222333', 'ddd', 'eee'] }
          it { is_expected.to eq(result) }
        end
        context do
          let(:strings) { ['aaa', 'bbb111', '22ccc2', '333ddd', 'eee'] }
          let(:result) { ['aaa', 'bbb11122', 'ccc2333', 'ddd', 'eee'] }
          it { is_expected.to eq(result) }
        end
      end

      context 'line breaks everywhere' do
        context do
          let(:strings) { ['aaa111', '2bbb222', '33ccc3', '4ddd44', '55eee5'] }
          let(:result) { ['aaa1112', 'bbb22233', 'ccc34', 'ddd4455', 'eee5'] }
          it { is_expected.to eq(result) }
        end
        context 'all strings are numbers' do
          context do
            let(:strings) { ['000', '111', '222', '333', '444'] }
            let(:result) { ['000111222333444'] }
            it { is_expected.to eq(result) }
          end
          context do
            let(:strings) { ['0', '1', '2', '3', '4'] }
            let(:result) { ['01234'] }
            it { is_expected.to eq(result) }
          end
        end
      end
    end

    context 'number not in line break' do
      context do
        let(:strings) { ['aaa', 'bbb111', 'c222cc', '333ddd', 'eee'] }
        let(:result) { ['aaa', 'bbb111', 'c222cc', '333ddd', 'eee'] }
        it { is_expected.to eq(result) }
      end
    end

    context 'without numbers' do
      let(:strings) { ['aaa', 'bbb', 'ccc', 'ddd', 'eee'] }
      let(:result) { ['aaa', 'bbb', 'ccc', 'ddd', 'eee'] }
      it { is_expected.to eq(result) }
    end

    context 'empty strings' do
      context do
        let(:strings) { ['', '', '', '', ''] }
        let(:result) { ['', '', '', '', ''] }
        it { is_expected.to eq(result) }
      end
      context do
        let(:strings) { [nil, nil, nil, nil, nil] }
        let(:result) { [] }
        it { is_expected.to eq(result) }
      end
    end

    context 'empty arguments' do
      context do
        let(:strings) { [] }
        let(:result) { [] }
        it { is_expected.to eq(result) }
      end
      context do
        let(:strings) { nil }
        let(:result) { [] }
        it { is_expected.to eq(result) }
      end
    end
  end

  describe '#shift_br_from_number!' do
    subject(:shift_br_from_number) { described_class.shift_br_from_number!(first, second) }
    before :each do
      shift_br_from_number
    end

    context 'number moved' do
      context do
        let(:first) { 'abc1' }
        let(:second) { '2abc' }
        it { expect(first).to eq('abc12') }
        it { expect(second).to eq('abc') }
      end
      context do
        let(:first) { 'abc123' }
        let(:second) { '456abc' }
        it { expect(first).to eq('abc123456') }
        it { expect(second).to eq('abc') }
      end
      context do
        let(:first) { 'abc123' }
        let(:second) { '456' }
        it { expect(first).to eq('abc123456') }
        it { expect(second).to eq('') }
      end
    end

    context 'number not moved' do
      context do
        let(:first) { 'abc' }
        let(:second) { '123abc' }
        it { expect(first).to eq('abc') }
        it { expect(second).to eq('123abc') }
      end
      context do
        let(:first) { 'abc123' }
        let(:second) { 'abc' }
        it { expect(first).to eq('abc123') }
        it { expect(second).to eq('abc') }
      end
      context do
        let(:first) { 'abc' }
        let(:second) { '123' }
        it { expect(first).to eq('abc') }
        it { expect(second).to eq('123') }
      end
    end

    context 'empty arguments' do
      context do
        let(:first) { '' }
        let(:second) { '' }
        it { expect(first).to eq('') }
        it { expect(second).to eq('') }
      end
      context do
        let(:first) { nil }
        let(:second) { nil }
        it { expect(first).to be_nil }
        it { expect(second).to be_nil }
      end
      context 'empty arguments' do
        context do
          let(:first) { '' }
          let(:second) { 'abc' }
          it { expect(first).to eq('') }
          it { expect(second).to eq('abc') }
        end
        context do
          let(:first) { nil }
          let(:second) { 'abc' }
          it { expect(first).to be_nil }
          it { expect(second).to eq('abc') }
        end
      end
    end
  end
end
