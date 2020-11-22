RSpec.describe Nmax do
  it 'has a version number' do
    expect(Nmax::VERSION).not_to be_nil
  end

  describe '#find' do
    subject(:find) { described_class.find(n, io: io, str_length: str_length, str_count: str_count) }

    before :all do
      @file_name = File.join(File.dirname(__FILE__), 'nmax_spec_test_file')
    end
    after :all do
      File.delete(@file_name)
    end

    let(:io) do
      File.open(@file_name, 'w') { |file| file.write(input_data) }
      File.new(@file_name)
    end

    context 'find one maximum number' do
      let(:n) { 1 }

      context 'one maximum in the middle of the string' do
        # точка - это каждый 10-ый символ
        let(:input_data) { "Lorem111 .ipsum 999.dolor sit.\namet222" }
        let(:str_length) { 10 }
        let(:str_count) { nil }
        it { is_expected.to eq [999] }
      end

      context 'three identical maximum' do
        # точка - это каждый 10-ый символ
        let(:input_data) { "aaaa 999 . 22 aaaaa. 999 aaaa.\n 33 aaaaa. 999" }
        let(:str_length) { 10 }
        let(:str_count) { nil }
        it { is_expected.to eq [999] }
      end

      context 'maximum on line break' do
        # ноль - это каждый 10-ый символ
        context do
          let(:input_data) { "aaaa aaa 012345678901234567890123 aaaa90 aaaaa78" }
          let(:str_length) { 10 }
          let(:str_count) { nil }
          it { is_expected.to eq [12345678901234567890123] }
        end
        context do
          let(:input_data) { "aaaa aaa 0\n\n1234567890\n1234567890\n\n\n123 aaaa90 aaaaa78" }
          let(:str_length) { 10 }
          let(:str_count) { nil }
          it { is_expected.to eq [12345678901234567890123] }
        end
      end

      context 'input data is a number' do
        let(:input_data) { "12345678901234567890" }
        let(:str_length) { 3 }
        let(:str_count) { nil }
        it { is_expected.to eq [12345678901234567890] }
      end
    end

    context "three maximum" do
      let(:n) { 3 }

      context do
        let(:input_data) { "333 222 777 444 999 444 999" }
        let(:str_length) { 4 }
        let(:str_count) { nil }
        it { is_expected.to eq [999, 777, 444] }
      end

      context 'on line break' do
        let(:input_data) { "333 55555 7777777 4444 999999999 4444 999999999" }
        let(:str_length) { 4 }
        let(:str_count) { nil }
        it { is_expected.to eq [999999999, 7777777, 55555] }
      end

      context "'str_count > 0'" do
        let(:input_data) { "333 55555 7777777 4444 999999999 4444 999999999" }
        let(:str_length) { 4 }
        let(:str_count) { 3 }
        it { is_expected.to eq [999999999, 7777777, 55555] }
      end
    end

    context 'not numbers' do
      let(:n) { 10 }
      let(:input_data) { "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt." }
      let(:str_length) { 10 }
      let(:str_count) { nil }
      it { is_expected.to eq [] }
    end
  end
end
