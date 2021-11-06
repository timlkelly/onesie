# frozen_string_literal: true

RSpec.describe Onesie::Manager, order: :custom do
  let(:manager) { subject }

  describe '#tasks' do
    before do
      allow(described_class).to receive(:tasks_paths).and_return(['spec/support/tasks'])
    end

    it 'returns an array of TaskProxies' do
      expect(manager.tasks).to include(Onesie::TaskProxy)
    end
  end
end
