describe Postmates::Client do
  let(:client) { postmates_test_client }
  let(:customer_id) { client.customer_id }

  context 'Customer Delivery endpoints' do

    describe '#quote' do
      let(:path) { path_to 'delivery_quotes' }
      let(:params) { payload 'quote_params.json' }
      before { stub_post path, params.merge(returns: 'quote.json') }

      it 'fetches a delivery quote' do
        expect(client.quote(params).id).to eq 'dqt_K9LFfpSZCdAJsk'
        expect(client.quote(params).fee).to eq 1350
      end

      it 'returns a Postmates::Quote' do
        expect(client.quote(params)).to be_a Postmates::Quote
      end
    end

    describe '#create' do
      let(:path) { path_to 'deliveries' }
      let(:params) { payload 'create_params.json' }
      before { stub_post path, params.merge(returns: 'delivery.json') }

      it 'creates a delivery' do
        expect(client.create(params).id).to eq 'del_K9LFxVVbl5sac-'
        expect(client.create(params).quote_id).to eq 'dqt_K9LFfpSZCdAJsk'
        expect(client.create(params).status).to eq 'pending'
        expect(client.create(params).manifest['description'])
          .to eq 'a box of kittens'
      end

      it 'returns a Postmates::Delivery' do
        expect(client.create(params)).to be_a Postmates::Delivery
      end
    end

    describe '#list' do
      let(:path) { path_to 'deliveries' }
      before { stub_get path, returns: 'deliveries.json' }

      it 'fetches a list of deliveries' do
        expect(client.list.size).to eq 6
        expect(client.list.first(3).map(&:id))
          .to eq %w(del_K9LFxVVbl5sac- del_K9FmiEl7tKY2i- del_K9Fm9OU1DhW3x-)
        expect(client.list.map(&:status).uniq).to eq %w(delivered canceled)
      end

      it 'returns an array of Postmates::Delivery objects' do
        expect(client.list).to be_an Array
        expect(client.list.first).to be_a Postmates::Delivery
      end
    end

    describe '#retrieve' do
      let(:delivery_id) { 'del_K9LFxVVbl5sac-' }
      let(:path) { path_to "deliveries/#{delivery_id}" }
      before { stub_get path, returns: 'delivery.json' }

      it 'fetches a single delivery by id' do
        expect(client.retrieve(delivery_id).id).to eq 'del_K9LFxVVbl5sac-'
        expect(client.retrieve(delivery_id).quote_id).to eq 'dqt_K9LFfpSZCdAJsk'
        expect(client.retrieve(delivery_id).status).to eq 'pending'
        expect(client.retrieve(delivery_id).manifest['description'])
          .to eq 'a box of kittens'
      end

      it 'returns a Postmates::Delivery' do
        expect(client.retrieve(delivery_id)).to be_a Postmates::Delivery
      end
    end

    describe '#cancel' do
      let(:delivery_id) { 'del_K9LFxVVbl5sac-' }
      let(:path) { path_to "deliveries/#{delivery_id}/cancel" }
      before { stub_post path, returns: 'delivery.json' }

      it 'cancels a single delivery by id' do
        expect(client.cancel(delivery_id).id).to eq 'del_K9LFxVVbl5sac-'
        expect(client.cancel(delivery_id).quote_id).to eq 'dqt_K9LFfpSZCdAJsk'
        expect(client.cancel(delivery_id).status).to eq 'pending'
        expect(client.cancel(delivery_id).manifest['description'])
          .to eq 'a box of kittens'
      end

      it 'returns a Postmates::Delivery' do
        expect(client.cancel(delivery_id)).to be_a Postmates::Delivery
      end
    end

    describe '#return' do
      let(:delivery_id) { 'del_K9LFxVVbl5sac-' }
      let(:path) { path_to "deliveries/#{delivery_id}/return" }
      before { stub_post path, returns: 'delivery.json' }

      it 'returns a single delivery by id' do
        expect(client.return(delivery_id).id).to eq 'del_K9LFxVVbl5sac-'
        expect(client.return(delivery_id).quote_id).to eq 'dqt_K9LFfpSZCdAJsk'
        expect(client.return(delivery_id).status).to eq 'pending'
        expect(client.return(delivery_id).manifest['description'])
          .to eq 'a box of kittens'
      end

      it 'returns a Postmates::Delivery' do
        expect(client.return(delivery_id)).to be_a Postmates::Delivery
      end
    end
  end
end