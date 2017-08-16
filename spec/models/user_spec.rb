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

  describe 'Twitter API KeyをDB保存時に暗号化する' do
    let(:user) { create(:user) }
    let(:consumer_key) { 'hogehoge' }
    let(:consumer_secret) { 'fugafuga' }
    let(:access_token) { 'hogefuga' }
    let(:access_token_secret) { 'fugahoge' }

    it 'paramsが正常に渡された場合、暗号化されて保存される' do
      params = {}
      params['twitter_consumer_key'] = consumer_key
      params['twitter_consumer_secret'] = consumer_secret
      params['twitter_access_token'] = access_token
      params['twitter_access_token_secret'] = access_token_secret
      user.update(params)

      expect(user.twitter_consumer_key).to eq consumer_key
      expect(user.twitter_consumer_secret).to eq consumer_secret
      expect(user.twitter_access_token).to eq access_token
      expect(user.twitter_access_token_secret).to eq access_token_secret
    end

    it 'paramsが空で渡された場合、空文字が暗号化されて保存される' do
      params = {}
      params['twitter_consumer_key'] = ''
      params['twitter_consumer_secret'] = ''
      params['twitter_access_token'] = ''
      params['twitter_access_token_secret'] = ''
      user.update(params)

      expect(user.twitter_consumer_key).to eq ''
      expect(user.twitter_consumer_secret).to eq ''
      expect(user.twitter_access_token).to eq ''
      expect(user.twitter_access_token_secret).to eq ''
    end
  end

  describe 'Zaim API KeyをDB保存時に暗号化する' do
    let(:user) { create(:user) }
    let(:request_token) { 'hogehoge' }
    let(:request_token_secret) { 'fugafuga' }
    let(:access_token) { 'hogefuga' }
    let(:access_token_secret) { 'fugahoge' }

    it 'paramsが正常に渡された場合、暗号化されて保存される' do
      params = {}
      params['zaim_request_token'] = request_token
      params['zaim_request_token_secret'] = request_token_secret
      params['zaim_access_token'] = access_token
      params['zaim_access_token_secret'] = access_token_secret
      user.update(params)

      expect(user.zaim_request_token).to eq request_token
      expect(user.zaim_request_token_secret).to eq request_token_secret
      expect(user.zaim_access_token).to eq access_token
      expect(user.zaim_access_token_secret).to eq access_token_secret
    end

    it 'paramsが空で渡された場合、空文字が暗号化されて保存される' do
      params = {}
      params['zaim_request_token'] = ''
      params['zaim_request_token_secret'] = ''
      params['zaim_access_token'] = ''
      params['zaim_access_token_secret'] = ''
      user.update(params)

      expect(user.zaim_request_token).to eq ''
      expect(user.zaim_request_token_secret).to eq ''
      expect(user.zaim_access_token).to eq ''
      expect(user.zaim_access_token_secret).to eq ''
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