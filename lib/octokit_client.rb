# frozen_string_literal: true

require 'octokit'

class OctokitClient
  PER_PAGE = 30

  def initialize(query, page)
    @client = Octokit::Client.new
    @query = query
    @page = page
  end

  def call
    result = search_github_repositories(@query, page: @page, per_page: PER_PAGE)
    total_count = result[:total_count]
    pages = build_pagination(total_count)
    repos = filter_empty_repos(result[:items])

    [repos, pages, total_count]
  end

  private

  def client
    @client ||= Octokit::Client.new
  end

  def search_github_repositories(query, options)
    @client.search_repositories(query, options)
  end

  def build_pagination(total_count)
    max_results = 1000
    (1..([total_count, max_results].min / PER_PAGE.to_f).round).to_a
  end

  def filter_empty_repos(items)
    items.select { |item| item[:size].positive? }
  end
end
