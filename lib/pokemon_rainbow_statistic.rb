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
      results << {name: row['pokemon_name'], data: [row['win_count']]}
    end
    results
  end

  def self.generate_top_5_pokemon_losers
    results = []
    query_result = ActiveRecord::Base.connection.execute(
      "SELECT
        pokemons.name AS pokemon_name,
        count(pokemons.id) AS lose_count
      FROM
        pokemon_battles
      INNER JOIN
        pokemons
      ON
      pokemon_battles.pokemon_loser_id = pokemons.id
      GROUP BY
        pokemon_battles.pokemon_loser_id,
        pokemons.name
      ORDER BY lose_count DESC
      LIMIT 5"
    )
    query_result.each do |row|
      results << {name: row['pokemon_name'], data: [row['lose_count']]}
    end
    results
  end

  def self.generate_top_5_pokemon_surrenders
    results = []
    query_result = ActiveRecord::Base.connection.execute(
      "SELECT
        pokemons.name AS pokemon_name,
        count(pokemons.id) AS surrender_count
      FROM
        pokemon_battle_logs
      INNER JOIN
        pokemons
      ON
        pokemon_battle_logs.attacker_id = pokemons.id
      WHERE
        pokemon_battle_logs.action_type = 'Surrender'
      GROUP BY
        pokemon_battle_logs.attacker_id,
        pokemons.name
      ORDER BY surrender_count DESC
      LIMIT 5"
    )
    query_result.each do |row|
      results << {name: row['pokemon_name'], data: [row['surrender_count']]}
    end
    results
  end

  def self.generate_top_5_pokemon_win_rates
    results = []
    query_result = ActiveRecord::Base.connection.execute(
    "select
        battle_total.pokemon_id,
        battle_total.pokemon_name,
        battle_total.battle_count,
        CASE WHEN count(pokemon_battles.id) = 0 THEN 0 ELSE count(pokemon_battles.id) * 100 / battle_total.battle_count END as win_rate
      from
          (
        select
          pokemons.id as pokemon_id,
          pokemons.name as pokemon_name,
          count(pokemon_battles.id) as battle_count
        from
          pokemon_battles
        inner join
          pokemons
        on
          pokemon_battles.pokemon1_id = pokemons.id or
          pokemon_battles.pokemon2_id = pokemons.id
        group by
          pokemons.id
        )
        battle_total
      left join
        pokemon_battles
      on
        battle_total.pokemon_id = pokemon_battles.pokemon_winner_id
      group by
        battle_total.pokemon_id,
        battle_total.pokemon_name,
        battle_total.battle_count
      order by
        win_rate desc,
        battle_total.battle_count desc
      limit 5
"
    )

    query_result.each do |row|
      results << {name: row['pokemon_name'], data: [row['win_rate']]}
    end
    results
  end

  def self.generate_top_5_pokemon_lose_rates
    results = []
    query_result = ActiveRecord::Base.connection.execute(
    " select
        battle_total.pokemon_id,
        battle_total.pokemon_name,
        battle_total.battle_count,
        CASE WHEN count(pokemon_battles.id) = 0 THEN 0 ELSE count(pokemon_battles.id) * 100 / battle_total.battle_count END as lose_rate
      from
          (
        select
          pokemons.id as pokemon_id,
          pokemons.name as pokemon_name,
          count(pokemon_battles.id) as battle_count
        from
          pokemon_battles
        inner join
          pokemons
        on
          pokemon_battles.pokemon1_id = pokemons.id or
          pokemon_battles.pokemon2_id = pokemons.id
        group by
          pokemons.id
        )
        battle_total
      left join
        pokemon_battles
      on
        battle_total.pokemon_id = pokemon_battles.pokemon_loser_id
      group by
        battle_total.pokemon_id,
        battle_total.pokemon_name,
        battle_total.battle_count
      order by
        lose_rate desc,
        battle_total.battle_count desc
      limit 5"
    )
    query_result.each do |row|
      results << {name: row['pokemon_name'], data: [row['lose_rate']]}
    end
    results
  end

  def self.generate_top_5_most_used_pokemons
    results = []
    query_result = ActiveRecord::Base.connection.execute(
      "SELECT
        pokemons.name AS pokemon_name,
        count(pokemons.id) AS used_count
      FROM
        pokemon_battles
      INNER JOIN
        pokemons
      ON
        pokemon_battles.pokemon1_id = pokemons.id or
        pokemon_battles.pokemon2_id = pokemons.id
      GROUP BY
        pokemons.name
      ORDER BY used_count DESC
      LIMIT 5"
    )
    query_result.each do |row|
      results << {name: row['pokemon_name'], data: [row['used_count'].to_i]}
    end
    results
  end

  def self.generate_top_5_most_used_skills
    results = []
    query_result = ActiveRecord::Base.connection.execute(
      "SELECT
        skills.name AS skill_name,
        count(skills.id) AS used_count
      FROM
        pokemon_battle_logs
      INNER JOIN
        skills
      ON
        pokemon_battle_logs.skill_id = skills.id
      GROUP BY
        skills.name
      ORDER BY used_count DESC
      LIMIT 5"
    )
    query_result.each do |row|
      results << {name: row['skill_name'], data: [row['used_count'].to_i]}
    end
    results
  end

  def self.generate_top_5_pokemon_damages
    results = []
    query_result = ActiveRecord::Base.connection.execute(
      "SELECT
        pokemons.name AS pokemon_name,
        SUM(pokemon_battle_logs.damage) as total_damage
      FROM
        pokemon_battle_logs
      INNER JOIN
        pokemons
      ON
        pokemon_battle_logs.attacker_id = pokemons.id
      WHERE
        damage IS NOT NULL
      GROUP BY
        pokemon_name
      ORDER BY
        total_damage DESC
      LIMIT 5"
    )
    query_result.each do |row|
      results << {name: row['pokemon_name'], data: [row['total_damage'].to_i]}
    end
    results
  end

  def self.generate_top_pokemon_in_pokedex_by_level(pokedex_id)
    results = []
    query_result = ActiveRecord::Base.connection.execute(
    " SELECT
        pokemons.id AS pokemon_id,
        pokemons.pokedex_id AS pokedex_id,
        pokemons.name AS pokemon_name,
        pokemons.current_health_point AS pokemon_current_health_point,
        pokemons.max_health_point AS pokemon_max_health_point,
        pokemons.attack AS pokemon_attack,
        pokemons.defence AS pokemon_defence,
        pokemons.speed AS pokemon_speed,
        pokemons.current_experience AS pokemon_current_experience,
        pokemons.level AS pokemon_level
      FROM
        pokemons
      INNER JOIN
        pokedexes
      ON
        pokedexes.id = #{pokedex_id} AND
        pokemons.pokedex_id = #{pokedex_id}
      GROUP BY
        pokemon_id
      ORDER BY
        pokemon_level DESC"
      )
    query_result.each do |row|
      results << {id: row['pokemon_id'], level: row['pokemon_level'].to_i, name: row['pokemon_name'], current_health_point: row['pokemon_current_health_point'], attack: row['pokemon_attack'], defence: row['pokemon_defence'], speed: row['pokemon_speed'], current_experience: row['pokemon_current_experience'], pokedex_id: row['pokedex_id'], max_health_point: row['pokemon_max_health_point']}
    end
    results
  end

  def self.generate_top_5_pokedex_average_level
    results = []
    query_result = ActiveRecord::Base.connection.execute(
      "SELECT
        pokedexes.name AS pokedex_name,
        AVG(Cast(pokemons.level as Float)) as average_level
      FROM
        pokedexes
      INNER JOIN
        pokemons
      ON
        pokedexes.id = pokemons.pokedex_id
      GROUP BY
        pokedex_name
      ORDER BY
        average_level DESC
      LIMIT 5"
    )
    query_result.each do |row|
      results << {name: row['pokedex_name'], data: [row['average_level']]}
    end
    results
  end

  def self.generate_top_used_pokemon_trainer(trainer_id)
    results = []
    datas = []
    query_result = ActiveRecord::Base.connection.execute(
    " SELECT
        pokemons.name AS pokemon_name,
        Cast (count(pokemons.name) AS Float) AS used_count
      FROM
        pokemons
      INNER JOIN
        pokemon_trainers
      ON
        pokemons.id = pokemon_trainers.pokemon_id
      INNER JOIN
        pokemon_battles
      ON
        pokemon_trainers.pokemon_id = pokemon_battles.pokemon1_id or
        pokemon_trainers.pokemon_id = pokemon_battles.pokemon2_id
      WHERE
        pokemon_trainers.trainer_id = #{trainer_id}
      GROUP BY
        pokemons.name
      ORDER BY
        used_count DESC"
      )
    total_count = 0
    query_result.each do |row|
      total_count += row['used_count']
    end

    query_result.each do |row|
      datas << {name: row['pokemon_name'],y: (row['used_count']/total_count*100).round(2)}
    end
    results = [{name: 'Pokemon'}, data: datas ]
    results
  end

  def self.generate_top_used_skill(trainer_id)
    # untuk mencatat skill yg digunakan itu ada di pokemon battle log,
    # jadi harusnya ambil count nya dari pokemon_battle_log
    results = []
    query_result = ActiveRecord::Base.connection.execute(
    " SELECT
        skills.name AS skill_name,
        count(skills.id) AS used_count
      FROM
        skills
      INNER JOIN
        pokemon_battle_logs
      ON
        skills.id = pokemon_battle_logs.skill_id
      INNER JOIN
        pokemon_trainers
      ON
        pokemon_battle_logs.attacker_id = pokemon_trainers.pokemon_id
      GROUP BY
        skills.id
      ORDER BY
        used_count DESC
      LIMIT 5"
      )
    query_result.each do |row|
      results << {name: row['skill_name'], data: [row['used_count']] }
    end
    results
  end

end