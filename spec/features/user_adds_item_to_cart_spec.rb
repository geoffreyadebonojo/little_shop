require 'rails_helper'

describe "when a user adds an item to their cart" do
  before(:each) do
    name_1 = "First User"
    address_1 = "123 Street"
    city_1 = "Denver"
    state_1 = "CO"
    zip_code_1 = 80000
    password_1 = "password1"
    email_1 = "e@mail.com"

    @user_1 = User.create(
      name: name_1,
      address: address_1,
      city: city_1,
      state: state_1,
      zip_code: zip_code_1,
      password: password_1,
      email: email_1,
      role: :merchant_user,
      status: :active
    )

    @item_1 = @user_1.items.create(
      id: 1,
      name: "First Item",
      price: 100,
      img_url: "https://static.grainger.com/rp/s/is/image/Grainger/12N166_AS01?$mdmain$",
      inventory_count: 5,
      description: "first description",
      status: :active
    )

    @item_2 = @user_1.items.create(
      id: 2,
      name: "Second Item",
      price: 200,
      img_url: "https://static.grainger.com/rp/s/is/image/Grainger/12N166_AS01?$mdmain$",
      inventory_count: 10,
      description: "second description",
      status: :active
    )
  end

  it "shows a flash message when a user adds a song" do

    visit item_path(@item_1)
    click_on "ADD TO CART"
    expect(current_path).to eq(carts_path)
    expect(page).to have_content("Your Shopping Cart")
    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_1.price)
    expect(page).to have_content("You now have 1 First Item")
    expect(page).to have_content("Cart:(1 items)")

    visit item_path(@item_2)
    click_on "ADD TO CART"
    expect(current_path).to eq(carts_path)
    expect(page).to have_content("Your Shopping Cart")
    expect(page).to have_content(@item_2.name)
    expect(page).to have_content(@item_2.price)
    expect(page).to have_content("You now have 1 Second Item")
    expect(page).to have_content("Cart:(2 items)")

    visit item_path(@item_1)
    click_on "ADD TO CART"
    expect(current_path).to eq(carts_path)
    expect(page).to have_content("Your Shopping Cart")
    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_1.price)
    expect(page).to have_content("You now have 2 First Item")
    expect(page).to have_content("Cart:(3 items)")

  end

  it "can increment items from cart page" do

  end

end
