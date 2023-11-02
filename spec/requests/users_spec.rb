# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users/register' do
    it 'returns http success' do
      post '/users/register', params: {
        email: 'myemail@gmail.com',
        timezone: 'Australia/Sydney'
      }

      expect(response).to have_http_status(:success)
    end
    it 'returns error when bad email' do
      post '/users/register', params: { email: 'myemail' }

      expect(JSON.parse(response.body)).to eq('error' => 'Validation failed: Email is invalid')
    end
  end

  describe 'GET #root' do
    let(:user) { create(:user, email: 'javier@gmail.com') }
    let!(:hits) { create_list(:hit, 10, user:, endpoint: '/') }
    let(:json_response) { JSON.parse(response.body, symbolize_names: true) }

    it 'Checks the User#reset_monthly_hits! resets properly' do
      t = Time.local(2022, 10, 31, 21, 0, 0)
      Timecop.travel(t)

      get '/', params: { email: user.email }

      expect(json_response.length).to eq(User.count)
      tz = TZInfo::Timezone.get('America/New_York')

      User.reset_monthly_hits!('America/New_York', (tz.utc_offset / 60 / 60))

      get '/', params: { email: user.email }

      expect(user.reload.monthly_hits).to eq(1)
      expect(user.hits.count).to eq(12)

      Timecop.return
    end
  end
end
