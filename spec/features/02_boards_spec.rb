require "rails_helper"

describe "/boards" do
  it "lists the names of each Board record in the database", points: 2 do
    the_user = User.new
    the_user.username = "claire"
    the_user.email = "claire@example.com"
    the_user.password = "password"
    the_user.save

    visit "/users/sign_in"

    within(:css, "form") do
      fill_in "Email", with: the_user.email
      fill_in "Password", with: the_user.password
      click_button "Log in"
    end

    board_chi = Board.new
    board_chi.name = "Chicago"
    board_chi.user_id = the_user.id
    board_chi.save

    visit "/boards"

    expect(page).to have_text(board_chi.name),
      "Expected page to have the name, '#{board_chi.name}'"
  end
end

describe "/boards" do
  it "has a form", points: 1 do
    the_user = User.new
    the_user.username = "claire"
    the_user.email = "claire@example.com"
    the_user.password = "password"
    the_user.save

    visit "/users/sign_in"

    within(:css, "form") do
      fill_in "Email", with: the_user.email
      fill_in "Password", with: the_user.password
      click_button "Log in"
    end

    visit "/boards"

    expect(page).to have_css("form", minimum: 1)
  end
end

describe "/boards" do
  it "has a label for 'Name' with text: 'Name'", points: 1, hint: h("copy_must_match label_for_input") do
    the_user = User.new
    the_user.username = "claire"
    the_user.email = "claire@example.com"
    the_user.password = "password"
    the_user.save

    visit "/users/sign_in"

    within(:css, "form") do
      fill_in "Email", with: the_user.email
      fill_in "Password", with: the_user.password
      click_button "Log in"
    end

    visit "/boards"

    expect(page).to have_css("label", text: "Name")
  end
end

describe "/boards" do
  it "creates a Board when 'Create board' form is submitted", points: 5, hint: h("button_type") do
    the_user = User.new
    the_user.username = "claire"
    the_user.email = "claire@example.com"
    the_user.password = "password"
    the_user.save

    visit "/users/sign_in"

    within(:css, "form") do
      fill_in "Email", with: the_user.email
      fill_in "Password", with: the_user.password
      click_button "Log in"
    end

    initial_number_of_boards = Board.count
    test_name = "Chicago"

    visit "/boards"

    fill_in "Name", with: "Chicago"
    click_on "Create board"
    final_number_of_boards = Board.count
    expect(final_number_of_boards).to eq(initial_number_of_boards + 1)
  end
end

describe "/boards/[ID]" do
  it "has a 'Delete listing' link if the user is the owner", points: 5 do
    the_user = User.new
    the_user.username = "claire"
    the_user.email = "claire@example.com"
    the_user.password = "password"
    the_user.save

    visit "/users/sign_in"

    within(:css, "form") do
      fill_in "Email", with: the_user.email
      fill_in "Password", with: the_user.password
      click_button "Log in"
    end

    board_chi = Board.new
    board_chi.name = "Chicago"
    board_chi.user_id = the_user.id
    board_chi.save

    listing_1 = Listing.new
    listing_1.title = "Guitar lessons"
    listing_1.body = "Learn with me"
    listing_1.expires_on = Date.today + 7.days
    listing_1.board_id = board_chi.id
    listing_1.user_id = the_user.id
    listing_1.save

    visit "/boards/#{board_chi.id}"

    expect(page).to have_tag("a", :text => /Delete listing/i)
  end
end
