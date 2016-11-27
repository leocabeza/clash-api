require_relative '../spec_helper.rb'

describe Clashinator::Clan do

  let(:clan_ok) do
    Clashinator::Clan.clan_info(config['token_test'], '#82JJP9PC')
  end

  describe 'when Clan class exists' do
    it 'must have a Base Class parent' do
      Clashinator::Clan.superclass.must_equal Clashinator::Base
    end
  end

  describe 'when search_clans class method exists' do
    it 'must include a class method named search_clans' do
      Clashinator::Clan.must_respond_to 'search_clans'
    end

    it 'must return an array of clan instances' do
      clans = Clashinator::Clan.search_clans(
        config['token_test'],
        name: 'vzlan warriors', limit: 1
      )
      clans.must_be_instance_of Clashinator::ArrayResource
      clans.items.length.wont_equal 0
      clans.items.first.must_be_instance_of Clashinator::Clan
      clans.items.first.must_respond_to 'location'
      clans.items.first.location.must_be_instance_of Clashinator::Location
      clans.items.first.must_respond_to 'badge_urls'
      clans.items.first.badge_urls.must_be_instance_of Clashinator::BadgeUrl
    end

    it 'must raise an error when wrong paging params are given' do
      lambda do
        Clashinator::Clan.search_clans(
          config['token_test'],
          name: 'vzlan warriors', limit: 1,
          after: '2938383838'
        )
      end.must_raise RuntimeError
    end

    it 'must raise an error when no query options given' do
      -> { Clashinator::Clan.search_clans }.must_raise ArgumentError
    end
  end

  describe 'when clan_info class method exists' do
    it 'must include a class method named clan_info' do
      Clashinator::Clan.must_respond_to 'clan_info'
    end

    it 'must return an instance of Clan' do
      clan_ok.must_be_instance_of Clashinator::Clan
    end

    it 'must return array hash attributes as objects' do
      clan_ok.must_respond_to 'member_list'
      clan_ok.member_list.must_be_instance_of Clashinator::ArrayResource
      clan_ok.member_list.items.first.must_be_instance_of Clashinator::Player
      clan_ok.must_respond_to 'location'
      clan_ok.location.must_be_instance_of Clashinator::Location
      clan_ok.must_respond_to 'badge_urls'
      clan_ok.badge_urls.must_be_instance_of Clashinator::BadgeUrl
    end

    it 'must raise an error when wrong clan_tag is provided' do
      -> { Clashinator::Clan.clan_info(config['token_test'], '#2222222222') }
        .must_raise RuntimeError
    end
  end

  describe 'when list_clan_member class method exists' do
    it 'must include a class method named list_clan_members' do
      Clashinator::Clan.must_respond_to 'list_clan_members'
    end

    it 'must return an array of clan members' do
      members = Clashinator::Clan.list_clan_members(
        config['token_test'], '#VQ2QUJG', limit: 1
      )
      members.must_be_instance_of Clashinator::ArrayResource
      members.items.first.must_be_instance_of Clashinator::Player
    end

    it 'must raise an error when no clan_tag is given' do
      -> { Clashinator::Clan.list_clan_members }.must_raise ArgumentError
    end

    it 'must raise an error when wrong paging params are given' do
      lambda do
        Clashinator::Clan.list_clan_members(
          config['token_test'],
          '#VQ2QUJG',
          limit: 1, after: '2938383838'
        )
      end.must_raise RuntimeError
    end
  end

  describe 'when list clan_war_log clan class method exists' do
    it 'must include a class method named clan_war_log' do
      Clashinator::Clan.must_respond_to 'clan_war_log'
    end

    it 'must return an array of war logs given that the clan ' \
      'war log is set to public' do
      war_logs = Clashinator::Clan.clan_war_log(
        config['token_test'], '#82JJP9PC', limit: 1
      )
      war_logs.must_be_instance_of Clashinator::ArrayResource
      war_logs.items.first.must_be_instance_of Clashinator::Warlog
    end

    it 'must raise an error when no clan_tag is given' do
      -> { Clashinator::Clan.clan_war_log }.must_raise ArgumentError
    end

    it 'must raise an error when wrong paging params are given' do
      lambda do
        Clashinator::Clan.clan_war_log(
          config['token_test'],
          '#82JJP9PC',
          limit: 1, after: '2938383838'
        )
      end.must_raise RuntimeError
    end

    it 'must raise an error when clan war log is set to private' do
      lambda do
        Clashinator::Clan.clan_war_log(
          config['token_test'], '#VQ2QUJG'
        )
      end.must_raise RuntimeError
    end
  end
end
