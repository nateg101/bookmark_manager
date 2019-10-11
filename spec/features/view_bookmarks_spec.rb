# frozen_string_literal: true

require "pg"

feature "Viewing bookmarks" do
  scenario "User looks at bookmarks" do
    create_urls

    visit "/bookmarks"

    expect(page).to have_link("BBC Sport", href: "https://www.bbc.co.uk/sport")
    expect(page).to have_link("Miniclip", href: "https://www.miniclip.com/games/en/")
    expect(page).to have_link("CN", href: "https://www.cartoonnetwork.co.uk/")
  end
end
