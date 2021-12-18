# frozen_string_literal: true

RSpec.describe Onesie::Manager do
  let(:manager) { described_class.new(runner: runner) }
  let(:runner) { class_double(Onesie::Runner, perform: true) }

  before do
    allow(described_class).to receive(:tasks_path).and_return('spec/support/tasks')
  end

  describe '#tasks' do
    it 'returns an array of TaskProxies' do
      expect(manager.tasks).to include(Onesie::TaskProxy)
    end
  end

  describe '#run_task' do
    context 'with a valid task filename' do
      let(:task_proxy_dbl) do
        instance_double(Onesie::TaskProxy, filename: '1234_foo_bar', run: true)
      end

      it 'does not raise an error' do
        expect {
          manager.run_task('20211106171205_test_task')
        }.not_to raise_error
      end

      it 'delegates to the Runner class' do
        allow(manager).to receive(:tasks).and_return([task_proxy_dbl])

        manager.run_task('1234_foo_bar')
        expect(runner).to have_received(:perform).with(task_proxy_dbl, manual_override: true)
      end
    end

    context 'with an invalid task filename' do
      it 'raises TaskNotFoundError' do
        expect {
          manager.run_task('20211212173107_bar')
        }.to raise_error(Onesie::TaskNotFoundError)
      end
    end
  end
end
