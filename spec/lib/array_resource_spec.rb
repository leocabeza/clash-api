require_relative '../spec_helper.rb'

describe Clashinator::ArrayResource do

  let(:array_resource) do
    Clashinator::ArrayResource.new(
      Clashinator::Clan,
      ['name' => 'Vzlan warriors', 'tag' => '#VQ2QUJG'],
      'cursors' => {
        'after' => 'after', 'before' => 'before'
      }
    )
  end

  describe 'when a hash of urls are provided' do
    it 'must respond to default attributes' do
      array_resource.must_respond_to 'model'
      array_resource.must_respond_to 'items'
      array_resource.must_respond_to 'paging'
    end

    it 'must return correct values of instance methods' do
      array_resource.model.must_equal Clashinator::Clan
      array_resource.items.must_be_instance_of Array
      array_resource.items.first.must_be_instance_of Clashinator::Clan
      array_resource
        .paging
        .must_be_instance_of Clashinator::ArrayResource::Cursor
      array_resource.paging.after.must_equal 'after'
      array_resource.paging.before.must_equal 'before'
    end
  end
end
