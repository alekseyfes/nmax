RSpec.describe NumbersFinder do
  subject(:numbers_finder) { described_class.new }

  describe '#call' do
    subject(:call) { numbers_finder.call(strings) }

    context 'numbers' do

      context 'one number' do
        context 'at the beginning' do
          let(:strings) { ['123aaa', 'bbb', 'ccc'] }
          it { is_expected.to eq [123] }
        end
        context 'at the end' do
          let(:strings) { ['aaa', 'bbb', 'ccc123'] }
          it { is_expected.to eq [123] }
        end
        context 'in the middle' do
          let(:strings) { ['aaa', 'bb123b', 'ccc'] }
          it { is_expected.to eq [123] }
        end
        context 'on line break' do
          let(:strings) { ['aaa123', '456bbb', 'ccc'] }
          it { is_expected.to eq [123456] }
        end
        context 'all strings is a numbers' do
          let(:strings) { ['111', '222', '333'] }
          it { is_expected.to eq [111222333] }
        end
        context 'just one string' do
          let(:strings) { ['123456'] }
          it { is_expected.to eq [123456] }
        end
      end

      context 'multiple numbers' do
        context 'different' do
          let(:strings) { ['111aaa', 'bb222b', 'ccc333'] }
          it { is_expected.to eq [111, 222, 333] }
        end
        context "identical" do
          let(:strings) { ['123aaa', 'bb123b', 'ccc123'] }
          it { is_expected.to eq [123] }
        end
        context 'on line break' do
          let(:strings) { ['aaa11', '11bbb22', '22ccc1', '111ddd'] }
          it { is_expected.to eq [1111, 2222] }
        end
      end
    end

    context 'not numbers' do
      let(:strings) { ['aaa', 'bbb', 'ccc'] }
      it { is_expected.to eq [] }
    end
    context 'empty array' do
      let(:strings) { [] }
      it { is_expected.to eq [] }
    end
  end
end
