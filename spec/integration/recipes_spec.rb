require 'rails_helper'

RSpec.describe 'Recipes', type: :feature do
  describe 'index' do
    before(:each) do
      @user = User.create(name: 'user1', email: 'user1@mail.com', password: '123456')
      sign_in @user
      @recipe = Recipe.create(user: @user, name: 'Fish and Chips', preparation_time: 1, cooking_time: 1,
                              description: 'main food', public: true)
      visit recipes_path
    end

    it 'renders name of recipe' do
      expect(page).to have_content(@recipe.name)
    end

    it 'renders description of the recipe' do
      expect(page).to have_content(@recipe.description)
    end

    it 'renders remove button' do
      expect(page).to have_content('remove')
    end

    it 'redirects to delete path' do
      click_button 'remove'
      expect(page).to have_current_path(recipes_path)
    end

    it 'renders a button to add recipe' do
      expect(page).to have_content('Add recipe')
    end

    it 'redirects to a form for new recipe' do
      click_link 'Add recipe'
      expect(page).to have_current_path(new_recipe_path)
    end
  end

  describe 'show' do
    before(:each) do
      @user = User.create(name: 'user1', email: 'user1@mail.com', password: '123456')
      sign_in @user
      @recipe = Recipe.create(user: @user, name: 'Fish and Chips', preparation_time: 1, cooking_time: 1,
                              description: 'main food', public: true)
      visit recipe_path(@recipe.id)
    end

    it 'renders name of recipe' do
      expect(page).to have_content(@recipe.name)
    end

    it 'renders description of the recipe' do
      expect(page).to have_content(@recipe.description)
    end

    it 'renders preparation time' do
      expect(page).to have_content(@recipe.preparation_time)
    end

    it 'renders cooking time' do
      expect(page).to have_content(@recipe.cooking_time)
    end

    it 'renders add ingredient button' do
      expect(page).to have_content('Add Ingredient')
    end

    it 'redirects to add ingredient page' do
      click_link 'Add Ingredient'
      expect(page).to have_current_path(new_recipe_recipe_food_path(@recipe))
    end

    it 'renders shopping list button' do
      expect(page).to have_content('Generate shopping list')
    end

    it 'redirects to shopping list' do
      click_link 'Generate shopping list'
      expect(page).to have_current_path(shopping_lists_path)
    end
  end
end
