require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:task) { FactoryGirl.create(:task, user_id: user.id) }

  describe "StateMachine" do
    describe 'init with' do
      it 'fresh' do
        expect(task.state).to eq('fresh')
      end
    end

    describe 'change state from fresh to' do
      before do
        task.started!
      end
      it 'started' do
        expect(task.state).to eq('started')
      end
    end

    describe 'change state from fresh to' do
      before do
        task.finished!
      end
      it 'finished' do
        expect(task.state).to eq('finished')
      end
    end
  end

  describe '.assign_to' do
    let(:task) { FactoryGirl.create(:task) }
    it 'success' do
      expect do
        task.assign_to(user)
      end.to change{task.reload.user_id}.from(nil).to(user.id)
    end
  end
end