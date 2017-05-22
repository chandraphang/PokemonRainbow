class PokemonRainbowStatistic
  def self.generate_top_5_pokemon_winners
    results = []
    query_result = ActiveRecord::Base.connection.execute(
      "SELECT
        pokemons.name AS pokemon_name,
        count(pokemons.id) AS win_count
      FROM
        pokemon_battles
      INNER JOIN
        pokemons
      ON
      pokemon_battles.pokemon_winner_id = pokemons.id
      GROUP BY
        pokemon_battles.pokemon_winner_id,
        pokemons.name
      ORDER BY win_count DESC
      LIMIT 5"
    )
    query_result.each do |row|
      results << {name: row['pokemon_name'], data: row['win_count']}
      # options = { font_size: 10, font_family: "Arial" }
      # raise 'po'
    end
    results
  end
end