class PokemonBattleCalculator
  RATIO = {
  :normal => {:normal => 1, :fighting => 1, :flying => 1, :poison => 1, :ground => 1, :rock => 0.5, :bug => 1, :ghost => 0, :steel => 0.5, :fire =>1, :water => 1, :grass => 1, :electric => 1, :psychic => 1, :ice => 1, :dragon => 1, :dark => 1, :fairy => 1},
    :fighting => {:normal => 2, :fighting => 1, :flying => 0.5, :poison => 0.5, :ground => 1, :rock => 2, :bug => 0.5, :ghost => 0, :steel => 2, :fire =>1, :water => 1, :grass => 1, :electric => 1, :psychic => 0.5, :ice => 2, :dragon => 1, :dark => 2, :fairy => 0.5},
    :flying => {:normal => 1, :fighting => 2, :flying => 1, :poison => 1, :ground => 1, :rock => 0.5, :bug => 2, :ghost => 1, :steel => 0.5, :fire =>1, :water => 1, :grass => 2, :electric => 0.5, :psychic => 1, :ice => 1, :dragon => 1, :dark => 1, :fairy => 1},
    :poison => {:normal => 1, :fighting => 1, :flying => 1, :poison => 0.5, :ground => 0.5, :rock => 0.5, :bug => 1, :ghost => 0.5, :steel => 0, :fire =>1, :water => 1, :grass => 2, :electric => 1, :psychic => 1, :ice => 1, :dragon => 1, :dark => 1, :fairy => 2},
    :ground => {:normal => 1, :fighting => 1, :flying => 0, :poison => 2, :ground => 1, :rock => 2, :bug => 0.5, :ghost => 1, :steel => 2, :fire =>2, :water => 1, :grass => 0.5, :electric => 2, :psychic => 1, :ice => 1, :dragon => 1, :dark => 1, :fairy => 1},
    :rock => {:normal => 1, :fighting => 0.5, :flying => 2, :poison => 1, :ground => 0.5, :rock => 1, :bug => 2, :ghost => 1, :steel => 0.5, :fire =>2, :water => 1, :grass => 1, :electric => 1, :psychic => 1, :ice => 2, :dragon => 1, :dark => 1, :fairy => 1},
    :bug => {:normal => 1, :fighting => 0.5, :flying => 0.5, :poison => 0.5, :ground => 1, :rock => 1, :bug => 1, :ghost => 0.5, :steel => 0.5, :fire =>0.5, :water => 1, :grass => 2, :electric => 1, :psychic => 2, :ice => 1, :dragon => 1, :dark => 2, :fairy => 0.5},
    :ghost => {:normal => 0, :fighting => 1, :flying => 1, :poison => 1, :ground => 1, :rock => 1, :bug => 1, :ghost => 2, :steel => 1, :fire =>1, :water => 1, :grass => 1, :electric => 1, :psychic => 2, :ice => 1, :dragon => 1, :dark => 0.5, :fairy => 1},
    :steel => {:normal => 1, :fighting => 1, :flying => 1, :poison => 1, :ground => 1, :rock => 2, :bug => 1, :ghost => 1, :steel => 0.5, :fire =>0.5, :water => 0.5, :grass => 1, :electric => 0.5, :psychic => 1, :ice => 2, :dragon => 1, :dark => 1, :fairy => 2},
    :fire => {:normal => 1, :fighting => 1, :flying => 1, :poison => 1, :ground => 1, :rock => 0.5, :bug => 2, :ghost => 1, :steel => 2, :fire =>0.5, :water => 0.5, :grass => 2, :electric => 1, :psychic => 1, :ice => 2, :dragon => 0.5, :dark => 1, :fairy => 1},
    :water => {:normal => 1, :fighting => 1, :flying => 1, :poison => 1, :ground => 2, :rock => 2, :bug => 1, :ghost => 1, :steel => 1, :fire =>2, :water => 0.5, :grass => 0.5, :electric => 1, :psychic => 1, :ice => 1, :dragon => 0.5, :dark => 1, :fairy => 1},
    :grass => {:normal => 1, :fighting => 1, :flying => 0.5, :poison => 0.5, :ground => 2, :rock => 2, :bug => 0.5, :ghost => 1, :steel => 0.5, :fire =>0.5, :water => 2, :grass => 0.5, :electric => 1, :psychic => 1, :ice => 1, :dragon => 0.5, :dark => 1, :fairy => 1},
    :electric => {:normal => 1, :fighting => 1, :flying => 2, :poison => 1, :ground => 0, :rock => 1, :bug => 1, :ghost => 1, :steel => 1, :fire =>1, :water => 2, :grass => 0.5, :electric => 0.5, :psychic => 1, :ice => 1, :dragon => 0.5, :dark => 1, :fairy => 1},
    :psychic => {:normal => 1, :fighting => 2, :flying => 1, :poison => 2, :ground => 1, :rock => 1, :bug => 1, :ghost => 1, :steel => 0.5, :fire =>1, :water => 1, :grass => 1, :electric => 1, :psychic => 0.5, :ice => 1, :dragon => 1, :dark => 0, :fairy => 1},
    :ice => {:normal => 1, :fighting => 1, :flying => 2, :poison => 1, :ground => 2, :rock => 1, :bug => 1, :ghost => 1, :steel => 0.5, :fire =>0.5, :water => 0.5, :grass => 2, :electric => 1, :psychic => 1, :ice => 0.5, :dragon => 2, :dark => 1, :fairy => 1},
    :dragon => {:normal => 1, :fighting => 1, :flying => 1, :poison => 1, :ground => 1, :rock => 1, :bug => 1, :ghost => 1, :steel => 0.5, :fire =>1, :water => 1, :grass => 1, :electric => 1, :psychic => 1, :ice => 1, :dragon => 2, :dark => 1, :fairy => 0},
    :dark => {:normal => 1, :fighting => 0.5, :flying => 1, :poison => 1, :ground => 1, :rock => 1, :bug => 1, :ghost => 2, :steel => 1, :fire =>1, :water => 1, :grass => 1, :electric => 1, :psychic => 2, :ice => 1, :dragon => 1, :dark => 0.5, :fairy => 0.5},
    :fairy => {:normal => 1, :fighting => 2, :flying => 1, :poison => 0.5, :ground => 1, :rock => 1, :bug => 1, :ghost => 1, :steel => 0.5, :fire =>0.5, :water => 1, :grass => 1, :electric => 1, :psychic => 1, :ice => 1, :dragon => 2, :dark => 2, :fairy => 1}
  }

  ExtraStats = Struct.new(
        :health_point,
        :attack_point,
        :defence_point,
        :speed_point
    )

  def self.calculate_damage(attacker, defender, skill)
    damage = 0
    random_number = rand(85..100)
    stab = 1
    if attacker.pokedex.element_type == defender.pokedex.element_type
      stab = 1.5
    end
    weakness = RATIO[attacker.pokedex.element_type.to_sym][defender.pokedex.element_type.to_sym]
    damage = (((((2*attacker.level/5+2)*attacker.attack*skill.power/defender.defence)/50)+2)*stab*weakness*(random_number.to_f/100)).round

  end

  def self.calculate_experience(loser_level)
    rand(20..150) * loser_level
  end

  def self.level_up?(winner_level, total_experience)
    experience_limit = winner_level^2 * 200
    if total_experience > experience_limit
        true
    else
        false
    end
  end


  def self.calculate_level_up_extra_stats

    extra = ExtraStats.new
    extra.health_point = rand(10..20)
    extra.attack_point = rand(1..5)
    extra.defence_point = rand(1..5)
    extra.speed_point = rand(1..5)

    extra
  end

end