require 'rails_helper'

RSpec.describe Translator::TranslatorCoordinator do
  it 'accepts an array of docs paths for initialization' do
    paths = ['voice/voice-api/guides/numbers.md', 'messages/external-accounts/overview.md']

    coordinator = described_class.new(paths: paths)

    expect(coordinator.paths).to be_an(Array)
  end

  describe '#requests' do
    it 'returns an Array of Translator::TranslationRequests instances' do
      paths = ['voice/voice-api/guides/numbers.md', 'messages/external-accounts/overview.md']
      coordinator = described_class.new(paths: paths)
      requests = coordinator.requests

      expect(requests).to all(be_a(Translator::TranslationRequest))
    end
  end

  describe '#jobs' do
    it 'returns the requests grouped by translation frequency in ascending order' do
      paths = ['voice/voice-api/guides/numbers.md', 'messages/external-accounts/overview.md']
      coordinator = described_class.new(paths: paths)
      jobs = coordinator.jobs
      expect(jobs.keys).to eql(jobs.keys.sort)
    end
  end
end