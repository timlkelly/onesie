# frozen_string_literal: true

RSpec.describe Onesie::Runner do
  let(:runner) { described_class.new(task) }
  let(:task) { instance_double(Onesie::TaskProxy, run: true) }

  describe '#perform' do
    it 'runs the tasks' do
      runner.perform

      expect(task).to have_received(:run)
    end

    it 'rescues StandardError' do
      allow(task).to receive(:run).and_raise(StandardError)

      expect {
        runner.perform
      }.not_to raise_error
    end

    it 'logs errors' do
      allow(task).to receive(:run).and_raise(StandardError, 'uh oh')

      expect {
        runner.perform
      }.to output(/The following Tasks contained errors/).to_stdout
    end
  end
end
