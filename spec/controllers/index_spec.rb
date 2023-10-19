# frozen_string_literal: true

require 'spec_helper'

describe 'Index Page' do
  describe 'GET /' do
    it 'return the home index page with search field' do
      get '/'
      expect(last_response.status).to eq 200
      expect(last_response.body).to include('<form action="/search" method="GET" class="navbar-item">')
    end
  end
end
