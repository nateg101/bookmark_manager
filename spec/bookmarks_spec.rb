# frozen_string_literal: true

require 'bookmarks'
require 'database_helpers'

describe Bookmarks do

  describe '.all' do
    it 'should return a list of bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      bookmark = Bookmarks.create(url: 'https://www.bbc.co.uk/sport', title: 'BBC Sport')
      Bookmarks.create(url: 'https://www.miniclip.com/games/en/', title: 'Miniclip')
      Bookmarks.create(url: 'https://www.cartoonnetwork.co.uk/', title: 'CN')

      bookmarks = Bookmarks.all

      expect(bookmarks.length).to eq 3
      expect(bookmarks.first).to be_a Bookmarks
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'BBC Sport'
      expect(bookmarks.first.url).to eq 'https://www.bbc.co.uk/sport'
    end
  end

  describe '.create' do
    it 'creates a new bookmark' do
      bookmark = Bookmarks.create(url: 'https://www.test.com/', title: 'Test')
      persisted_data = persisted_data(table: 'bookmarks', id: bookmark.id)

      expect(bookmark).to be_a Bookmarks
      expect(bookmark.id).to eq persisted_data.first['id']
      expect(bookmark.title).to eq 'Test'
      expect(bookmark.url).to eq 'https://www.test.com/'
    end

    it 'does not create new bookmarks if URL is not valid' do
      Bookmarks.create(url: 'not a real bookmark', title: 'not a real bookmark')
      expect(Bookmarks.all).not_to include 'not a real bookmark'
    end
  end

  describe '.delete' do
    it 'removes a user specified bookmark' do
      bookmark = Bookmarks.create(url: 'https://www.bbc.co.uk/sport', title: 'BBC Sport')

      Bookmarks.delete(id: bookmark.id)

      expect(Bookmarks.all.length).to eq 0
    end
  end

  describe '.update' do
    it 'updates the bookmark with the new fields' do
      bookmark = Bookmarks.create(url: 'https://www.bbc.co.uk/sport', title: 'BBC Sport')
      update_bmark = Bookmarks.update(id: bookmark.id, url: 'https://www.sky.com/', title: 'Sky')

      expect(update_bmark).to be_a Bookmarks
      expect(update_bmark.id).to eq bookmark.id
      expect(update_bmark.title).to eq 'Sky'
      expect(update_bmark.url).to eq 'https://www.sky.com/'
    end
  end

  describe '.find' do
    it 'returns the required bookmark' do
      bookmark = Bookmarks.create(url: 'https://www.bbc.co.uk/sport', title: 'BBC Sport')

      result = Bookmarks.find(id: bookmark.id)

      expect(result).to be_a Bookmarks
      expect(result.id).to eq bookmark.id
      expect(result.title).to eq 'BBC Sport'
      expect(result.url).to eq 'https://www.bbc.co.uk/sport'
    end
  end
end
