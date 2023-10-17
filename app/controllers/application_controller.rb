# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'

class ApplicationController < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    set :public_folder, File.join(root, '../../public')
  end

  configure :production do
    set :static, false
  end

  configure do
    set :root, "#{File.dirname(__FILE__)}/../../"
    set :views, File.join(root, 'app/views')
  end

  helpers do
    def partial(template, locals = {})
      erb(template, layout: false, locals:)
    end
  end
end
