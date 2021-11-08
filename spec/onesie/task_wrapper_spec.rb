# frozen_string_literal: true

RSpec.describe Onesie::TaskWrapper do
  let(:task_class) do
    Class.new(Onesie::Task) do
      allowed_environments :development
      manual_task enabled: false

      def run; end
    end
  end
  let(:task) { task_class.new }

  before do
    task_class.class_eval { prepend Onesie::TaskWrapper } # rubocop:disable RSpec/DescribedClass
  end

  describe '#run' do
    context 'when ran in an allowed environment' do
      before do
        allow(task).to receive(:task_record_present?).and_return(false)
        allow(Onesie::TaskRecord).to receive(:create!).and_return(true)
      end

      it 'runs the task' do
        task.run

        expect(Onesie::TaskRecord).to have_received(:create!)
      end
    end

    context 'when ran in an disallowed environment' do
      before do
        allow(Onesie::TaskRecord).to receive(:find_by)
      end

      let(:klass) do
        Class.new(Onesie::Task) do
          allowed_environments :production
          manual_task enabled: false

          def run; end
        end
      end

      it 'does not run the task' do
        klass.class_eval { prepend Onesie::TaskWrapper } # rubocop:disable RSpec/DescribedClass
        klass.new.run

        expect(Onesie::TaskRecord).not_to have_received(:find_by)
      end
    end

    context 'when there is no TaskRecord present' do
      before do
        allow(task).to receive(:task_record_present?).and_return(false)
        allow(Onesie::TaskRecord).to receive(:create!).and_return(true)
      end

      context 'with a non-manual task' do
        it 'records the task' do
          task.run

          expect(Onesie::TaskRecord).to have_received(:create!)
        end
      end

      context 'with a manual task without the manual_override' do
        before do
          allow(task).to receive(:manual_task?).and_return(true)
        end

        it 'does not run the task' do
          task.run

          expect(Onesie::TaskRecord).not_to have_received(:create!)
        end
      end

      context 'with a manual task with the manual_override' do
        it 'runs the task' do
          task.run(manual_override: true)

          expect(Onesie::TaskRecord).to have_received(:create!)
        end
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
