# frozen_string_literal: true

require 'pg'

feature 'Add new bookmark' do
  scenario 'User adds a new bookmark to database' do
    visit '/bookmarks/new'
    fill_in('url', with: 'https://www.google.com/')
    fill_in('title', with: 'Google')
    click_button('Submit')
    expect(page).to have_link('Google', href: 'https://www.google.com/')
  end

  scenario 'The bookmark must be a valid URL' do
    visit '/bookmarks/new'
    fill_in('url', with: 'fake bookmark')
    click_button('Submit')

    expect(page).not_to have_content 'fake bookmark'
    expect(page).to have_content 'Submit a valid URL please babe.'
  end
end
