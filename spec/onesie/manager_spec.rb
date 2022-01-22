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
        expect(runner).to have_received(:perform)
          .with(task_proxy_dbl, manual_override: true)
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

  describe '#rerun' do
    def task_proxy_factory(args)
      instance_double(Onesie::TaskProxy, delete: true, run: true, **args)
    end

    let!(:task_a) { task_proxy_factory(filename: 'first_task', version: '20220119212203') }
    let!(:task_b) { task_proxy_factory(filename: 'middle_task', version: '20220121171540') }
    let!(:task_c) { task_proxy_factory(filename: 'last_task', version: '20220122164134') }
    let(:tasks) { [task_b, task_c, task_a] }

    before { allow(manager).to receive(:tasks).and_return(tasks) }

    context 'when the filename is specified' do
      it 'deletes the task' do
        manager.rerun(filename: 'middle_task')

        expect(task_b).to have_received(:delete)
      end

      it 'reruns the task' do
        manager.rerun(filename: 'middle_task')

        expect(runner).to have_received(:perform)
          .with(task_b, manual_override: true)
      end
    end

    context 'when the filename is not specified' do
      it 'deletes the most recent task' do
        manager.rerun

        expect(task_c).to have_received(:delete)
      end

      it 'reruns the most recent task' do
        manager.rerun

        expect(runner).to have_received(:perform)
          .with(task_c, manual_override: true)
      end
    end
  end
end
