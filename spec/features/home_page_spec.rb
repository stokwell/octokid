# frozen_string_literal: true

require 'spec_helper'

describe 'Home Page' do
  it 'shows navbar with search field' do
    visit '/'
    expect(page).to have_content 'octokid'
    expect(page).to have_field('query', placeholder: 'Search Github repos')
    expect(page).to have_button('Search')
  end
end
