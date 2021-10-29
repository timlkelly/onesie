# frozen_string_literal: true

RSpec.describe Onesie::Task do
  describe '.manual_task' do
    it 'defines #manual_task?' do
      klass = Class.new(described_class)

      expect(klass.instance_methods(false)).not_to match_array(:manual_task?)
      klass.manual_task
      expect(klass.instance_methods(false)).to match_array(:manual_task?)
    end
  end
end
