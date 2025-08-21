require "rails_helper"

describe "User" do
  it "has a column called 'encrypted_password' of type 'string'", points: 1 do
    new_user = User.new
    expect(new_user.attributes).to include("encrypted_password"),
      "Expected to have a column called 'encrypted_password', but didn't find one."
    expect(User.column_for_attribute("encrypted_password").type).to be(:string),
      "Expected column to be of type 'string' but wasn't."
    end
  end

describe "User" do
  it "does not have a password column", points: 1 do
      expect(User.columns.map(&:name)).to_not include("password"),
        "Expected User to NOT have a column called 'password', but found one."
  end
end

describe "User" do
  it "has a column called 'username' of type 'string'", points: 1 do
    new_user = User.new
    expect(new_user.attributes).to include("username"),
      "Expected to have a column called 'username', but didn't find one."
    expect(User.column_for_attribute("username").type).to be(:string),
      "Expected column to be of type 'string' but wasn't."
  end
end
