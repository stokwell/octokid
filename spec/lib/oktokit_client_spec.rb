# frozen_string_literal: true

require 'spec_helper'
require 'octokit_client'

RSpec.describe OctokitClient do
  describe '#call' do
    let(:query) { 'ruby' }
    let(:page) { 1 }

    before do 
      client = OctokitClient.new(query, page)
      allow(client).to receive(:search_github_repositories).and_return(
        total_count: 50,
        items: [{ size: 100 }, { size: 0 }, { size: 50 }]
      )
    end

    it 'performs a GitHub search and returns results' do
      repos, pages, total_count = client.call

      expect(repos).to eq([{ size: 100 }, { size: 50 }])
      expect(pages).to eq([1, 2])
      expect(total_count).to eq(50)
    end
  end
end
