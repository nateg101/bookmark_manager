# frozen_string_literal: true

require 'pg'

feature 'Remove an existing bookmark' do
  scenario 'User removes a bookmark' do
    Bookmarks.create(url: 'www.miniclip.com', title: 'Miniclip')

    visit '/bookmarks'
    expect(page).to have_link('Miniclip', href: 'www.miniclip.com')

    first('.bookmark').click_button('Delete')

    expect(current_path). to eq '/bookmarks'
    expect(page).to_not have_link('Miniclip', href: 'www.miniclip.com')
  end
end
