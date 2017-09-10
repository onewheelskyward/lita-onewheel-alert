require 'spec_helper'

describe Lita::Handlers::OnewheelAlert, lita_handler: true do
  # def load_mock(file)
  #   mock = File.open("spec/fixtures/#{file}.json").read
  #   allow(RestClient).to receive(:get) { mock }
  # end

  it 'hears me' do
    send_message 'onewheelskyward this thing'
    expect(replies.last).to eq('Heard onewheelskyward this thing')
  end
end
