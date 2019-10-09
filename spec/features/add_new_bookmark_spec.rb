# frozen_string_literal: true

require 'pg'

feature 'Add new bookmark' do
  scenario 'User adds a new bookmark to database' do
    visit '/bookmarks/new'
    fill_in('url', with: 'www.reddit.com')
    fill_in('title', with: 'Reddit')
    click_button('Submit')
    expect(page).to have_link('Reddit', href: 'www.reddit.com')
  end
end
