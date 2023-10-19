# frozen_string_literal: true

require_relative '../../lib/octokit_client'

class PagesController < ApplicationController
  get '/' do
    erb :index
  end

  get '/search' do
    query = params[:query]
    page = params[:page] || 1

    if query.empty?
      redirect '/'
    else
      repos, pages, total_count = OctokitClient.new(query, page).call

      erb :search, locals: {
        query:,
        repos:,
        pages:,
        total_count:
      }
    end
  end
end
