require 'rails_helper'

RSpec.describe User, type: :model do

  describe '#find_or_create_from_auth_hash' do
    let(:provider) { 'twitter' }
    let(:uid) { '123456789' }
    let(:nickname) { 'test_name' }
    let(:image_url) { 'http://image_url' }

    describe '対象のユーザーが未登録だった場合' do
      it 'auth_hashで渡したレコードが登録されて返る' do
        auth_hash = set_auth_hash(provider, uid, nickname, image_url)

        user = User.find_or_create_from_auth_hash(auth_hash)
        expect(user.provider).to eq provider
        expect(user.uid).to eq uid
        expect(user.nickname).to eq nickname
        expect(user.image_url).to eq image_url

        cnt_user = User.where(provider: provider, uid: uid).count
        expect(cnt_user).to eq 1
      end
    end

    describe '対象のユーザーが登録済みだった場合' do
      it 'auth_hashで渡したユーザーが検索されて返る' do
        create(:user, provider: provider, uid: uid, nickname: nickname, image_url: image_url)

        auth_hash = set_auth_hash(provider, uid, nickname, image_url)

        user = User.find_or_create_from_auth_hash(auth_hash)
        expect(user.provider).to eq provider
        expect(user.uid).to eq uid
        expect(user.nickname).to eq nickname
        expect(user.image_url).to eq image_url

        cnt_user = User.where(provider: provider, uid: uid).count
        expect(cnt_user).to eq 1
      end
    end
  end

  def set_auth_hash(provider, uid, nickname, image_url)
    auth_hash = {}
    auth_hash[:info] = {}

    auth_hash[:provider]         = provider
    auth_hash[:uid]              = uid
    auth_hash[:info][:nickname]  = nickname
    auth_hash[:info][:image]     = image_url

    auth_hash
  end
end