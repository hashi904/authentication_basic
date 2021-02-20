require 'rails_helper'

describe Authentication::JwtAuthenticator do
  let(:describe_class) { Authentication::JwtAuthenticator }
  let!(:jwt){ "eyJhbGciOiJIUzI1NiJ9.eyJwcmVsb2FkIjoiaG9nZSIsImV4cCI6MTYxMzc5NzU3OX0.JzN6FcpLNWDnap0c2QWSY08c3oID6wwvijGYJ4VlbPU" }

  describe '#encode' do
    subject { describe_class.encode(preload) }
    let(:preload) { { test: 'test' } }

    context '' do
      before do
        allow(JWT).to receive(:encode).and_return(jwt)
      end
      it 'return jwt' do
        is_expected.to eq jwt
      end
    end
  end

  describe '#decode' do
    subject { describe_class.decode(jwt) }

    context '' do
      it 'return hash with preload' do
        expect(subject.first).to have_key('preload')
      end
    end
  end
end
