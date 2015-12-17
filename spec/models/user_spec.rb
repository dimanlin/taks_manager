require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { FactoryGirl.create(:user, password: 'password', password_confirmation: 'password') }

  describe '.update_password' do
    context 'valid password' do
      it 'update' do
        expect(user.update_password!('password', 'new_password', 'new_password')).to be true
      end
    end

    context 'invalid password' do
      it do
        expect(user.update_password!('password', 'new_password', 'fake')).to be false
      end
    end
  end
end