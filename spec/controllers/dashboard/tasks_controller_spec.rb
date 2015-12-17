require 'rails_helper'

RSpec.describe Dashboard::TasksController, type: :controller do
  render_views

  let(:user) { FactoryGirl.create(:user)}


  before do
    sign_in user
  end

  describe '.index' do
    context 'request html' do
      before do
        @task = FactoryGirl.create(:task, user_id: user.id)
        get :index
      end

      it 'respond my tasks' do
        expect(assigns[:tasks].size).to eq(1)
        expect(assigns[:tasks]).to include(@task)
      end
    end

    context 'request json' do
      before do
        @task = FactoryGirl.create(:task, user_id: user.id)
        get :index, format: :json
      end

      it 'respond my tasks' do
        expect(JSON.parse(response.body).count).to eq(1)
        expect(response.body).to eq([@task].to_json)
      end
    end
  end

  describe '.edit' do
    before do
      @task = FactoryGirl.create(:task, user_id: user.id)
      get :edit, id: @task
    end

    it 'success' do
      expect(response).to be_success
    end
  end

  describe '.update' do
    context 'success' do
      context 'html request' do
        before do
          @task = FactoryGirl.create(:task, user_id: user.id, name: 'name')
        end

        it 'success' do
          expect do
            post :update, id: @task, task: {name: 'new_name'}
          end.to change{@task.reload.name}.from('name').to('new_name')
        end
      end

      context 'json request' do
        before do
          @task = FactoryGirl.create(:task, user_id: user.id, name: 'name')
          post :update, id: @task, task: {name: 'new_name'}, format: :json
        end

        it 'success' do
          expect(JSON.parse(response.body)['task'].present?).to be true
          expect(JSON.parse(response.body)['task']['name']).to eq('new_name')
        end
      end
    end

    context 'fail' do
      context 'html request' do
        before do
          @task = FactoryGirl.create(:task, user_id: user.id, name: 'name')
          post :update, id: @task, task: {name: ''}
        end

        it 'success' do
          expect(@task.reload.name).to eq('name')
        end
      end
    end
  end

  describe '.show' do
    before do
      @task = FactoryGirl.create(:task, user_id: user.id)
      get :show, id: @task
    end

    it 'success' do
      expect(response).to be_success
    end
  end

  describe '.new' do
    before do
      get :new
    end

    it 'success' do
      expect(response).to be_success
    end
  end

  describe '.create' do
    context 'success' do
      context 'html request' do
        it 'success' do
          expect do
            post :create, task: { name: 'name', description: 'description' }
          end.to change{Task.count}.from(0).to(1)
        end
      end

      context 'json request' do
        before do
          post :create, format: :json, task: { name: 'name', description: 'description' }
        end

        it 'success' do
          expect(Task.count).to eq(1)
          expect(JSON.parse(response.body)['task']['errors']).to eq({})
        end
      end
    end

    context 'failure' do
      context 'html request' do
        before do
          post :create, task: { name: 'name' }
        end

        it 'object was not created' do
          expect(Task.count).to eq(0)
        end
      end

      context 'json request' do
        before do
          post :create, format: :json, task: { name: 'name' }
        end

        it 'success' do
          expect(Task.count).to eq(0)
          expect(JSON.parse(response.body)['task']['errors']).to eq({"description"=>["не может быть пустым"]})
        end
      end
    end
  end

  describe 'assign_to' do
    context 'html request' do
      before do
        @task = FactoryGirl.create(:task, state: 'fresh')
      end

      it 'assign to user' do
        expect do
          post :assign_to_me, id: @task.id
        end.to change{@task.reload.user_id}.from(nil).to(user.id)
      end
    end

    context 'json request' do
      before do
        @task = FactoryGirl.create(:task, state: 'fresh')
        post :assign_to_me, id: @task.id, format: :json
      end

      it 'assign to user' do
        expect(@task.reload.user_id).to eq(user.id)
        expect(JSON.parse(response.body)['task'].present?).to be true
      end
    end
  end
end
