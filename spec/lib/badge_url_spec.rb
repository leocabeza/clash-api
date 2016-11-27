require_relative '../spec_helper.rb'

describe Clashinator::BadgeUrl do
  let(:badge_url) do
    Clashinator::BadgeUrl.new(
      'tiny' => 'tiny_url', 'small' => 'small_url',
      'medium' => 'medium_url', 'large' => 'large_url'
    )
  end

  describe 'when a hash of urls are provided' do
    it 'must respond to small, large, medium instance methods' do
      badge_url.must_respond_to 'tiny'
      badge_url.must_respond_to 'small'
      badge_url.must_respond_to 'large'
      badge_url.must_respond_to 'medium'
    end

    it 'must return correct values of instance methods' do
      badge_url.tiny.must_equal 'tiny_url'
      badge_url.small.must_equal 'small_url'
      badge_url.large.must_equal 'large_url'
      badge_url.medium.must_equal 'medium_url'
    end
  end
end
