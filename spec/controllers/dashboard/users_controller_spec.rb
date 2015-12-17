require 'rails_helper'

RSpec.describe Dashboard::UsersController, type: :controller do
  render_views

  let(:user) { FactoryGirl.create(:user, email: 'email@gmail.com', password: 'root0000', password_confirmation: 'root0000')}

  before do
    sign_in user
  end

  describe '.show' do
    before do
      get :show, id: user.id
    end

    it 'success' do
      expect(response).to be_success
    end
  end

  describe '.edit' do
    before do
      get :edit, id: user.id
    end

    it 'success' do
      expect(response).to be_success
    end
  end

  describe '.update' do
    context 'success' do
      it 'success' do
        expect do
          post :update, id: user.id, user: { email: 'new_email@gmail.com' }
        end.to change{user.reload.email}.from('email@gmail.com').to('new_email@gmail.com')
      end
    end

    context 'failure' do
      before do
        post :update, id: user.id, user: { email: '' }
      end

      it do
        expect(user.reload.email).to eq('email@gmail.com')
      end
    end
  end

  describe '.edit_password' do
    before do
      get :edit_password, id: user.id
    end

    it 'success' do
      expect(response).to be_success
    end
  end

  describe '.update_password' do
    context 'success' do
      before do
        post :update_password, user: {current_password: 'root0000', password: 'new_password', password_confirmation: 'new_password'}, id: user.id
      end

      it 'redirect to root' do
        expect(response).to redirect_to root_path
      end
    end

    context 'failure' do
      before do
        post :update_password, user: {current_password: 'root0000', password: 'new_password', password_confirmation: 'fake'}, id: user.id
      end

      it 'redirect to root' do
        expect(response).to render_template(:edit_password)
      end
    end
  end
end
