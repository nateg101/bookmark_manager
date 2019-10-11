# frozen_string_literal: true

require 'pg'

def persisted_data(id:)
  connection = PG.connect(dbname: 'bookmark_manager_test')
  result = connection.query("SELECT * FROM bookmarks WHERE id = #{id};")
end

def create_urls
  Bookmarks.create(url: 'https://www.bbc.co.uk/sport', title: 'BBC Sport')
  Bookmarks.create(url: 'https://www.miniclip.com/games/en/', title: 'Miniclip')
  Bookmarks.create(url: 'https://www.cartoonnetwork.co.uk/', title: 'CN')
end
