# frozen_string_literal: true

require 'pg'

feature 'Update and exisiting bookmark' do
  scenario 'User changes the url or title of bookmark' do
    bookmark = Bookmarks.create(url: 'www.miniclip.com', title: 'Miniclip')

    visit '/bookmarks'
    expect(page).to have_link('Miniclip', href: 'www.miniclip.com')

    first('.bookmark').click_button('Update')
    expect(current_path).to eq "/bookmarks/#{bookmark.id}/update"

    fill_in('url', with: 'www.games.com')
    fill_in('title', with: 'Buff Games')
    click_button('Submit')

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('Miniclip', href: 'www.miniclip.com')
    expect(page).to have_link('Buff Games', href: 'www.games.com')
  end
end
