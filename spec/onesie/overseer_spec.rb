# frozen_string_literal: true

RSpec.describe Onesie::Overseer, order: :custom do
  let(:overseer) { subject }
  let(:task) { instance_double(Onesie::Tasks::TestTask, run: true) }

  before do
    stub_const('Onesie::TASKS_DIR', 'spec/support/tasks')
  end

  describe '#initialize' do
    it 'loads the available Tasks', order_number: 0 do
      expect {
        overseer
      }.to change(Onesie::Tasks, :constants).from([]).to([:TestTask])
    end
  end

  describe '#run_task' do
    it 'prepends the TaskWrapper', order_number: 1 do
      overseer.run_task(:TestTask)

      expect(Onesie::Tasks::TestTask.ancestors).to include(Onesie::TaskWrapper)
    end

    it 'instantiates a new Task instance', order_number: 2 do
      ovrsr = overseer
      allow(Onesie::Tasks::TestTask).to receive(:new).and_return(task)

      ovrsr.run_task(:TestTask)

      expect(Onesie::Tasks::TestTask).to have_received(:new)
    end

    it 'runs the Task', order_number: 3 do
      ovrsr = overseer
      allow(Onesie::Tasks::TestTask).to receive(:new).and_return(task)

      ovrsr.run_task(:TestTask)

      expect(task).to have_received(:run)
    end
  end
end
