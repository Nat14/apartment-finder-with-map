require 'rails_helper'

RSpec.feature "ApartmentUsers", type: :feature do
  describe "as a user"
  it "can signup" do
    add_user
    expect(page).to have_text('Welcome! You have signed up successfully.')
  end

  it "can login" do
    add_user
    click_on 'Log Out'
    page.fill_in 'Email', with: 'bat@a.com'
    page.fill_in 'Password', with: 'bat12345'
    click_on 'Log in'
    expect(page).to have_text('Signed in successfully.')
  end

  it "cannot login w wrong password" do
    add_user
    click_on 'Log Out'
    page.fill_in 'Email', with: 'bat@a.com'
    page.fill_in 'Password', with: 'bat12'
    click_on 'Log in'
    expect(page).to have_text('Invalid email or password.')
  end

  it "can log out" do
    add_user
    click_on 'Log Out'
    expect(page).to have_text('You need to sign in or sign up before continuing.')
  end

  def add_user
    visit '/'
    click_link 'Sign up'
    page.fill_in 'Email', with: 'bat@a.com'
    page.fill_in 'Password', with: 'bat12345'
    page.fill_in 'Password confirmation', with: 'bat12345'
    click_button 'Sign up'
  end

end
