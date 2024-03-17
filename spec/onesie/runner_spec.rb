# frozen_string_literal: true

RSpec.describe Onesie::Runner do
  let(:runner) { described_class.new(tasks) }
  let(:tasks)  { [task] }
  let(:task) do
    instance_double(Onesie::TaskProxy,
      name: 'TaskyMcTaskFace',
      run: true,
      version: '20211122223807')
  end

  describe '#perform' do
    it 'runs the tasks' do
      runner.perform

      expect(task).to have_received(:run)
    end

    context 'with tasks out of version order' do
      let(:task_one) { instance_double(Onesie::TaskProxy, version: '20211122223807') }
      let(:task_two) { instance_double(Onesie::TaskProxy, version: '20211124224842') }
      let(:task_three) { instance_double(Onesie::TaskProxy, version: '20211125224842') }
      let(:tasks) { [task_two, task_three, task_one] }

      it 'orders the task by version' do
        expect(runner.tasks).to eq([task_one, task_two, task_three])
      end
    end

    it 'rescues StandardError' do
      allow(task).to receive(:run).and_raise(StandardError)
      allow(runner).to receive(:print_errors)

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
