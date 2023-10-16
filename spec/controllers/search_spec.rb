# frozen_string_literal: true

require 'spec_helper'

describe 'Search Page' do
  let(:search) do
    get('/search', query:, page:)
  end
  let(:query) { 'q' }
  let(:page) { 1 }
  let(:stub_octokit_request) do
    stub_request(:get, "https://api.github.com/search/repositories?page=#{page}&per_page=30&q=#{query}")
      .with(
        headers: {
          'Accept' => 'application/vnd.github.v3+json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type' => 'application/json',
          'User-Agent' => 'Octokit Ruby Gem 5.6.1'
        }
      )
      .to_return(
        status: 200,
        body: File.read('./spec/support/files/octokit_response.json'),
        headers: { 'Content-Type' => 'application/json' }
      )
  end

  before do
    stub_octokit_request
    search
  end

  describe 'GET /search' do
    it 'return the search results page with found repo' do
      expect(stub_octokit_request).to have_been_requested
      expect(last_response.status).to eq 200
      expect(last_response.body).to include('<a href=https://github.com/dtrupenn/Tetris>https://github.com/dtrupenn/Tetris</a>')
    end

    context 'with empty query' do
      let(:query) { '' }

      it 'redirects to index page' do
        expect(stub_octokit_request).not_to have_been_requested
        expect(last_response).to be_redirect
        follow_redirect!
        expect(last_request.url).to eq 'http://example.org/'
      end
    end
  end
end
