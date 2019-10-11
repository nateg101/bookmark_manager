# frozen_string_literal: true

require 'pg'

feature 'Remove an existing bookmark' do
  scenario 'User removes a bookmark' do
    Bookmarks.create(url: 'https://www.miniclip.com/games/en/', title: 'Miniclip')

    visit '/bookmarks'
    expect(page).to have_link('Miniclip', href: 'https://www.miniclip.com/games/en/')

    first('.bookmark').click_button('Delete')

    expect(current_path). to eq '/bookmarks'
    expect(page).to_not have_link('Miniclip', href: 'https://www.miniclip.com/games/en/')
  end
end
