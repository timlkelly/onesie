# frozen_string_literal: true

RSpec.describe Onesie::Runner do
  let(:runner) { described_class.new(tasks) }
  let(:task)   { instance_double(Onesie::TaskProxy, run: true, version: '20211122223807') }
  let(:tasks)  { [task] }

  describe '#perform' do
    it 'runs the tasks' do
      runner.perform

      expect(task).to have_received(:run)
    end

    context 'with tasks out of version order' do
      let(:task1) { instance_double(Onesie::TaskProxy, version: '20211122223807') }
      let(:task2) { instance_double(Onesie::TaskProxy, version: '20211124224842') }
      let(:task3) { instance_double(Onesie::TaskProxy, version: '20211125224842') }
      let(:tasks) { [task2, task3, task1] }

      it 'orders the task by version' do
        expect(runner.tasks).to eq([task1, task2, task3])
      end
    end

    it 'rescues StandardError' do
      allow(task).to receive(:run).and_raise(StandardError)

      expect { runner.perform }.not_to raise_error
    end

    it 'logs errors' do
      allow(task).to receive(:run).and_raise(StandardError)

      expect {
        runner.perform
      }.to output(/The following Tasks contained errors/).to_stdout
    end
  end
end
