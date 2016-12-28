require_relative '../spec_helper.rb'

describe Clashinator::Player do

  let(:player) do
    Clashinator::Player.player_info(
      connection, '#QOCRLV90'
    )
  end

  describe 'when Player class exists' do
    it 'must have a Base Class parent' do
      Clashinator::Player.superclass.must_equal Clashinator::Base
    end
  end

  describe 'when player_info class method exists' do
    it 'must include a class method named player_info' do
      Clashinator::Player.must_respond_to 'player_info'
    end

    it 'must return an instance of player' do
      player.must_be_instance_of Clashinator::Player
    end

    it 'must respond to default attributes' do
      player.must_respond_to 'tag'
      player.must_respond_to 'name'
      player.must_respond_to 'town_hall_level'
      player.must_respond_to 'exp_level'
      player.must_respond_to 'trophies'
      player.must_respond_to 'best_trophies'
      player.must_respond_to 'war_stars'
      player.must_respond_to 'attack_wins'
      player.must_respond_to 'defense_wins'
      player.must_respond_to 'role'
      player.must_respond_to 'donations'
      player.must_respond_to 'donations_received'
      player.must_respond_to 'clan'
      player.must_respond_to 'league'
      player.must_respond_to 'achievements'
      player.must_respond_to 'troops'
      player.must_respond_to 'heroes'
      player.must_respond_to 'spells'
    end

    it 'must have hash attributes as objects' do
      player.clan.must_be_instance_of Clashinator::Clan
      player.league.must_be_instance_of Clashinator::League
      player.achievements.must_be_instance_of Clashinator::ArrayResource
      player.achievements.items.first
            .must_be_instance_of Clashinator::Achievement
      player.troops.must_be_instance_of Clashinator::ArrayResource
      player.troops.items.first.must_be_instance_of Clashinator::Troop
      player.heroes.must_be_instance_of Clashinator::ArrayResource
      player.heroes.items.first.must_be_instance_of Clashinator::Hero
      player.spells.must_be_instance_of Clashinator::ArrayResource
      player.spells.items.first.must_be_instance_of Clashinator::Spell
    end

    it 'must raise an error when wrong player_tag is provided' do
      lambda do
        Clashinator::Player.player_info(
          connection, '2222222222222'
        )
      end.must_raise RuntimeError
    end
  end
end
