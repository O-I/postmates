describe Postmates do
  describe '.new' do
    it 'returns a Postmates::Client' do
      expect(Postmates.new).to be_a Postmates::Client
    end
  end

  describe '.configure' do
    it 'sets the api_key and customer_id' do
      Postmates.configure do |config|
        config.api_key = '1234'
        config.customer_id = 'abcd'
      end

      expect(Postmates.api_key).to eq '1234'
      expect(Postmates.customer_id).to eq 'abcd'
    end
  end
end