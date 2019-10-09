# frozen_string_literal: true

require 'pg'

def persisted_data(id:)
  connection = PG.connect(dbname: 'bookmark_manager_test')
  result = connection.query("SELECT * FROM bookmarks WHERE id = #{id};")
end

def create_urls
  Bookmarks.create(url: 'www.bbc.co.uk/sport', title: 'BBC Sport')
  Bookmarks.create(url: 'www.miniclip.com', title: 'Miniclip')
  Bookmarks.create(url: 'www.cartoonnetwork.co.uk', title: 'CN')
end
