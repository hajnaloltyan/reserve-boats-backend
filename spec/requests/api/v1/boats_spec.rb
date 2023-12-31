require 'swagger_helper'

RSpec.describe 'api/v1/boats', type: :request do
  path '/api/v1/boats' do
    get('list boats') do
      tags 'Boats Controller'
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

    post('create boat') do
      tags 'Boats Controller'
      response(200, 'successful') do
        consumes 'application/json'
        parameter name: :reservation, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string },
            description: { type: :string },
            price: { type: :decimal },
            color: { type: :string },
            rent_price: { type: :decimal },
            user_id: { type: :integer },
            picture: { type: :string }
          },
          required: %w[name description price color rent_price user_id picture]
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

  path '/api/v1/boats/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show boats') do
      tags 'Boats Controller'
      response(200, 'successful') do
        let(:id) { '123' }

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

    delete('delete boat') do
      tags 'Boats Controller'
      response(200, 'successful') do
        let(:id) { '123' }

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
