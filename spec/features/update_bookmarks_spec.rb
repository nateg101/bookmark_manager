# frozen_string_literal: true

require 'pg'

feature 'Update and exisiting bookmark' do
  scenario 'User changes the url or title of bookmark' do
    bookmark = Bookmarks.create(url: 'https://www.miniclip.com/games/en/', title: 'Miniclip')

    visit '/bookmarks'
    expect(page).to have_link('Miniclip', href: 'https://www.miniclip.com/games/en/')

    first('.bookmark').click_button('Update')
    expect(current_path).to eq "/bookmarks/#{bookmark.id}/update"

    fill_in('url', with: 'https://www.games.co.uk/')
    fill_in('title', with: 'Buff Games')
    click_button('Submit')

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('Miniclip', href: 'https://www.miniclip.com/games/en/')
    expect(page).to have_link('Buff Games', href: 'https://www.games.co.uk/')
  end
end
