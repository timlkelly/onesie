# frozen_string_literal: true

RSpec.describe Onesie::Manager, order: :custom do
  let(:manager) { subject }

  before do
    allow(described_class).to receive(:tasks_paths).and_return(['spec/support/tasks'])
  end

  describe '#tasks' do
    it 'returns an array of TaskProxies' do
      expect(manager.tasks).to include(Onesie::TaskProxy)
    end
  end

  describe '#run_task' do
    context 'with a valid task version' do
      let(:task_proxy_dbl) do
        instance_double(Onesie::TaskProxy, version: '20211106171205', run: true)
      end

      it 'does not raise an error' do
        expect {
          manager.run_task('20211106171205')
        }.not_to raise_error
      end

      it 'runs the task' do
        allow(manager).to receive(:tasks).and_return([task_proxy_dbl])

        manager.run_task('20211106171205')
        expect(task_proxy_dbl).to have_received(:run)
      end
    end

    context 'with an invalid task version' do
      it 'raises TaskNotFoundError' do
        expect {
          manager.run_task('1234567890')
        }.to raise_error(Onesie::TaskNotFoundError)
      end
    end
  end
end
