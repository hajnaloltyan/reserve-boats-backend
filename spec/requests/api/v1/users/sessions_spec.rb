require 'swagger_helper'

RSpec.describe 'users/sessions', type: :request do
  path '/login' do
    get('new session') do
      tags 'User Login'
      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/login' do
    post('create session') do
      response(200, 'successful') do
        tags 'User Login'
        consumes 'application/json'
        parameter name: :user, in: :body, schema: {
          type: :object,
          properties: {
            user: {
              type: :object,
              properties: {
                name: { type: :string }
              },
              required: [:name]
            }
          },
          required: [:user]
        }
        let(:user) { { name: 'API Test' } }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
