RSpec.describe MaxFinder do
  subject(:max_finder) { described_class.new(count) }

  describe '#call' do
    subject(:call) { max_finder.call(numbers, max) }

    context 'one by one' do
      context do
        let(:numbers) { [1] }
        let(:max) { [2] }
        context do
          let(:count) { 1 }
          it { is_expected.to eq [2] }
        end
        context do
          let(:count) { 2 }
          it { is_expected.to eq [2, 1] }
        end
        context do
          let(:count) { 0 }
          it { is_expected.to eq [] }
        end
      end
      context do
        let(:numbers) { [2] }
        let(:max) { [1] }
        context do
          let(:count) { 1 }
          it { is_expected.to eq [2] }
        end
        context do
          let(:count) { 2 }
          it { is_expected.to eq [2, 1] }
        end
        context do
          let(:count) { 0 }
          it { is_expected.to eq [] }
        end
      end
    end

    context 'identical maximum values' do
      let(:numbers) { [1, 1, 2, 2, 2] }
      let(:max) { [] }
      context do
        let(:count) { 1 }
        it { is_expected.to eq [2] }
      end
      context do
        let(:count) { 2 }
        it { is_expected.to eq [2, 1] }
      end
      context do
        let(:count) { 0 }
        it { is_expected.to eq [] }
      end
    end

    context "'count' is greater than array length" do
      let(:numbers) { [1, 2, 3] }
      let(:max) { [] }
      let(:count) { 10 }
      it { is_expected.to eq [3, 2, 1] }
    end

    context "'numbers' is filled" do
      let(:numbers) { [1, 20, 40, 60, 80] }

      context "'max' is filled" do
        let(:max) { [70, 50, 30, 10] }

        context do
          let(:count) { 4 }
          it { is_expected.to eq [80, 70, 60, 50] }
        end
        context do
          let(:count) { 1 }
          it { is_expected.to eq [80] }
        end
        context do
          let(:count) { 0 }
          it { is_expected.to eq [] }
        end
      end

      context "'max' is not filled" do
        let(:max) { [] }

        context do
          let(:count) { 4 }
          it { is_expected.to eq [80, 60, 40, 20] }
        end
        context do
          let(:count) { 1 }
          it { is_expected.to eq [80] }
        end
        context do
          let(:count) { 0 }
          it { is_expected.to eq [] }
        end
      end
    end
  end
end
