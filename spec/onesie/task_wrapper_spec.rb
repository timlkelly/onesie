# frozen_string_literal: true

RSpec.describe Onesie::TaskWrapper do
  let(:task_class) do
    Class.new do
      def run; end
    end
  end
  let(:task) { task_class.new }

  # rubocop:disable RSpec/DescribedClass
  before do
    task_class.class_eval { prepend Onesie::TaskWrapper }
  end
  # rubocop:enable RSpec/DescribedClass

  describe '#run' do
    context 'when there is no TaskRecord present' do
      before do
        allow(task).to receive(:task_record_present?).and_return(false)
        allow(Onesie::TaskRecord).to receive(:create!).and_return(true)
      end

      it 'records the task' do
        task.run

        expect(Onesie::TaskRecord).to have_received(:create!)
      end
    end

    context 'when an existing TaskRecord is present' do
      before do
        allow(task).to receive(:task_record_present?).and_return(true)
        allow(Onesie::TaskRecord).to receive(:create!).and_return(true)
      end

      it 'does not record the task' do
        task.run

        expect(Onesie::TaskRecord).not_to have_received(:create!)
      end
    end
  end
end
