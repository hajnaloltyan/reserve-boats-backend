require 'swagger_helper'

RSpec.describe 'users/registrations', type: :request do
  path '/signup/sign_up' do
    get('new registration') do
      tags 'Users Registration'
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

  path '/signup' do
    post('create registration') do
      response(200, 'successful') do
        tags 'Users Registration'
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
