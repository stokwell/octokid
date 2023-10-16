# frozen_string_literal: true

require 'spec_helper'

describe 'Search' do
  it 'returns github repos' do
    visit '/'
    fill_in :query, with: 'stokwell'
    click_on('Search')
    expect(page).to have_current_path('/search?query=stokwell')
    expect(page).to have_content 'stokwell.github.io'
  end
end
