require 'json'
require 'rails_helper'

RSpec.describe UseZaimApi, type: :service do

  describe '::sum_payment_amount' do
    it 'パラメーターが渡された場合、合計値が返却される' do
      params = '{"money":[{"amount":1000}, {"amount":2000}, {"amount":3000}]}'
      json_params = JSON.parse(params)

      expect(UseZaimApi.sum_payment_amount(json_params).to_i).to eq 6000
    end

    it '返却値に計算可能な値が存在しない場合、0が返却される' do
      params = '{"money":[]}'
      json_params = JSON.parse(params)

      expect(UseZaimApi.sum_payment_amount(json_params).to_i).to eq 0
    end
  end

  # TODO: Zaim APIを叩くテストの見直し
end