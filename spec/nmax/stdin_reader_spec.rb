RSpec.describe StdinReader do
  subject(:reader) { described_class.new(io: io, str_length: str_length, str_count: str_count) }

  describe '#call' do
    subject(:call) { reader.call }

    before :all do
      @file_name = File.join(File.dirname(__FILE__), 'stdin_reader_spec_test_file')
    end
    after :all do
      File.delete(@file_name)
    end

    let(:input_data) { "Lorem ipsum dolor sit amet, consectetur adipiscing elit" }
    let(:io) do
      File.open(@file_name, 'w') { |file| file.write(input_data) }
      File.new(@file_name)
    end

    context 'one string length 30' do
      let(:str_length) { 30 }
      let(:str_count) { 1 }
      let(:result) { ["Lorem ipsum dolor sit amet, co"] }
      it { is_expected.to eq result }
    end

    context 'one string length 1' do
      let(:str_length) { 1 }
      let(:str_count) { 1 }
      let(:result) { ["L"] }
      it { is_expected.to eq result }
    end

    context '3 strings of length 10' do
      let(:str_length) { 10 }
      let(:str_count) { 3 }
      let(:result) { ["Lorem ipsu", "m dolor si", "t amet, co"] }
      it { is_expected.to eq result }
    end

    context 'all strings of length 10' do
      let(:str_length) { 10 }
      let(:str_count) { nil }
      let(:result) { ["Lorem ipsu", "m dolor si", "t amet, co", "nsectetur ", "adipiscing", " elit"] }
      it { is_expected.to eq result }
    end

    context 'input data with new lines' do
      let(:str_length) { 10 }
      let(:str_count) { nil }
      let(:input_data) { "Lorem\n\n\nipsum dolor\nsit amet, consectetur adipiscing\n\nelit" }
      let(:result) { ["Lorem", "ipsum dolo", "r", "sit amet, ", "consectetu", "r adipisci", "ng", "elit"] }
      it { is_expected.to eq result }
    end
  end
end
