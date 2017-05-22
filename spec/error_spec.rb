describe Postmates::Error do
  let(:client) { postmates_test_client }
  let(:customer_id) { client.customer_id }

  context 'A request' do
    describe 'with invalid parameters' do
      let(:params) { {} }
      before do
        stub_post(path_to('deliveries'),
                  params.merge(response_code: 400,
                               returns: 'invalid_params.json'))
      end

      it 'raises Postmates::BadRequest' do
        expect { client.create }
          .to raise_error Postmates::BadRequest
      end
    end

    describe 'with incorrect authentication' do
      let(:bad_client) { Postmates.new }
      before do
        stub_get(path_to('deliveries'),
                 response_code: 401, returns: 'unauthorized.json')
      end

      it 'raises Postmates::Unauthorized' do
        expect { bad_client.list }
          .to raise_error Postmates::Unauthorized
      end
    end

    describe 'when customer account is suspended' do
      before do
        stub_get(path_to('deliveries'),
          response_code: 402, returns: 'service_unavailable.json')
      end

      it 'raises Postmates::CustomerSuspended' do
        expect { client.list }
          .to raise_error Postmates::CustomerSuspended
      end
    end

    describe 'Forbidden' do
      let(:bad_client) { Postmates.new }
      before do
        stub_get(path_to('deliveries'),
                 response_code: 403, returns: 'forbidden.json')
      end

      it 'raises Postmates::Forbidden' do
        expect { bad_client.list }
          .to raise_error Postmates::Forbidden
      end
    end

    describe 'for a non-existent resource' do
      before do
        stub_get(path_to('deliveries/bad-id'),
                 response_code: 404, returns: 'not_found.json')
      end

      it 'raises Postmates::NotFound' do
        expect { client.retrieve('bad-id') }
          .to raise_error Postmates::NotFound
      end
    end

    describe 'when there is a problem processing the request' do
      before do
        stub_get(path_to('deliveries'),
                 response_code: 500, returns: 'server_error.json')
      end

      it 'raises Postmates::InternalServerError' do
        expect { client.list }
          .to raise_error Postmates::InternalServerError
      end
    end

    describe 'when service is unavailable' do
      before do
        stub_get(path_to('deliveries'),
                 response_code: 503, returns: 'service_unavailable.json')
      end

      it 'raises Postmates::ServiceUnavailable' do
        expect { client.list }
          .to raise_error Postmates::ServiceUnavailable
      end
    end

    describe 'with an unknown error' do
      before do
        stub_get(path_to('deliveries'),
          response_code: 504, returns: 'unknown.json')
      end

      it 'raises Postmates::Error' do
        expect { client.list }
          .to raise_error Postmates::Error
      end
    end
  end
end
