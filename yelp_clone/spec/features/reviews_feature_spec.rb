require 'rails_helper'

feature 'reviewing' do
  # before {Restaurant.create name: 'KFC'}

  scenario 'allows users to leave a review using a form' do
     visit '/'
     sign_up
     create_restaurant
     click_link 'Review KFC'
     fill_in "Thoughts", with: "so so"
     select '3', from: 'Rating'
     click_button 'Leave Review'
     expect(current_path).to eq '/restaurants'
     expect(page).to have_content('so so')
  end

  scenario 'allows users to only review once using a form' do
    visit '/'
    sign_up
    create_restaurant
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "a"
    select '2', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('already reviewed')
  end

  scenario 'allows users to only delete their reviews' do
    visit '/'
    sign_up
    create_restaurant
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    click_link 'Delete review'
    expect(page).to have_content('deleted successfully')
  end

  scenario 'allows users to only delete their reviews' do
    visit '/'
    sign_up
    create_restaurant
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    click_link 'Sign out'
    sign_up_other
    click_link 'Delete review'
    expect(page).to have_content('Can\'t delete')
  end

  scenario 'displays an average rating for all reviews' do
    visit '/'
    sign_up
    create_restaurant
    leave_review('Great', '5')
    expect(page).to have_content('Average rating: 5')
  end

  scenario 'displays an average rating for all reviews' do
    visit '/'
    sign_up
    create_restaurant
    leave_review('Great!', '5')
    expect(page).to have_content('Average rating: 5 ★★★★★')
  end
end
