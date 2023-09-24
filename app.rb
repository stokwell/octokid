# frozen_string_literal: true

require 'octokit'
require 'sinatra'

module Octokid
  class App < Sinatra::Base
    PER_PAGE = 30

    configure do
      set :root, File.dirname(__FILE__)
      set :public_folder, 'public'
    end

    get '/' do
      erb :index
    end

    get '/results' do
      if !params[:query].empty?
        client = Octokit::Client.new
        result = client.search_repositories(params[:query], { per_page: PER_PAGE, page: params[:page] })
        search_result = result[:total_count] > 1000 ? 1000 : result[:total_count]
        pages = (1..search_result / PER_PAGE).to_a
        repos = result[:items]

        erb :results, locals: { query: params[:query], repos:, pages:, total_count: result[:total_count] }
      else
        redirect '/'
      end
    end
  end
end
