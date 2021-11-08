# frozen_string_literal: true

RSpec.describe Onesie::Task do
  describe '.allowed_environments' do
    it 'defines #allowed_environments?' do
      klass = Class.new(described_class)

      expect(klass.instance_methods(false)).not_to match_array(:allowed_environment?)
      klass.allowed_environments :test, :integration, :staging, :production, :all
      expect(klass.instance_methods(false)).to match_array(:allowed_environment?)
    end
  end

  describe '#allowed_environment?' do
    let(:task) { klass.new }

    context 'when the environment is allowed' do
      let(:klass) do
        Class.new(described_class) do
          allowed_environments :development
        end
      end

      it 'returns true' do
        expect(task.allowed_environment?).to be true
      end
    end

    context 'when the environment is not allowed' do
      let(:klass) do
        Class.new(described_class) do
          allowed_environments :production
        end
      end

      it 'returns false' do
        expect(task.allowed_environment?).to be false
      end
    end

    context 'when all environments are allowed' do
      let(:klass) do
        Class.new(described_class) do
          allowed_environments :all
        end
      end

      it 'returns true' do
        expect(task.allowed_environment?).to be true
      end
    end
  end

  describe '.manual_task' do
    it 'defines #manual_task?' do
      klass = Class.new(described_class)

      expect(klass.instance_methods(false)).not_to match_array(:manual_task?)
      klass.manual_task
      expect(klass.instance_methods(false)).to match_array(:manual_task?)
    end
  end
end
