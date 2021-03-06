require 'test_helper'

class PokemonBattlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pokemon_battle = pokemon_battles(:one)
  end

  test "should get index" do
    get pokemon_battles_url
    assert_response :success
  end

  test "should get new" do
    get new_pokemon_battle_url
    assert_response :success
  end

  test "should create pokemon_battle" do
    assert_difference('PokemonBattle.count') do
      post pokemon_battles_url, params: { pokemon_battle: {  } }
    end

    assert_redirected_to pokemon_battle_url(PokemonBattle.last)
  end

  test "should show pokemon_battle" do
    get pokemon_battle_url(@pokemon_battle)
    assert_response :success
  end

  test "should get edit" do
    get edit_pokemon_battle_url(@pokemon_battle)
    assert_response :success
  end

  test "should update pokemon_battle" do
    patch pokemon_battle_url(@pokemon_battle), params: { pokemon_battle: {  } }
    assert_redirected_to pokemon_battle_url(@pokemon_battle)
  end

  test "should destroy pokemon_battle" do
    assert_difference('PokemonBattle.count', -1) do
      delete pokemon_battle_url(@pokemon_battle)
    end

    assert_redirected_to pokemon_battles_url
  end
end
