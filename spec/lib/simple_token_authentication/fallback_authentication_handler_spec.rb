require 'spec_helper'

describe SimpleTokenAuthentication::FallbackAuthenticationHandler do

  it_behaves_like 'an authentication handler'

  it 'delegates authentication to Devise::Controllers::Helpers through a controller', private: true do
    controller = double()
    allow(controller).to receive(:authenticate_user!).and_return('Devise response.')

    entity = double()
    entity.stub_chain(:name, :singularize, :underscore).and_return('user')

    # delegating consists in sending the message
    expect(controller).to receive(:authenticate_user!)
    response = subject.authenticate_entity!(controller, entity)

    # and returning the response
    expect(response).to eq 'Devise response.'
  end
end