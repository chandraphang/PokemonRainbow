require 'test_helper'

class PokemonBattleLogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pokemon_battle_log = pokemon_battle_logs(:one)
  end

  test "should get index" do
    get pokemon_battle_logs_url
    assert_response :success
  end

  test "should get new" do
    get new_pokemon_battle_log_url
    assert_response :success
  end

  test "should create pokemon_battle_log" do
    assert_difference('PokemonBattleLog.count') do
      post pokemon_battle_logs_url, params: { pokemon_battle_log: {  } }
    end

    assert_redirected_to pokemon_battle_log_url(PokemonBattleLog.last)
  end

  test "should show pokemon_battle_log" do
    get pokemon_battle_log_url(@pokemon_battle_log)
    assert_response :success
  end

  test "should get edit" do
    get edit_pokemon_battle_log_url(@pokemon_battle_log)
    assert_response :success
  end

  test "should update pokemon_battle_log" do
    patch pokemon_battle_log_url(@pokemon_battle_log), params: { pokemon_battle_log: {  } }
    assert_redirected_to pokemon_battle_log_url(@pokemon_battle_log)
  end

  test "should destroy pokemon_battle_log" do
    assert_difference('PokemonBattleLog.count', -1) do
      delete pokemon_battle_log_url(@pokemon_battle_log)
    end

    assert_redirected_to pokemon_battle_logs_url
  end
end
