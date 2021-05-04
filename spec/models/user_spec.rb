# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  full_name              :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#create" do
    context "when valid" do
      let(:user) { User.new(email: 'test@test.com', password: '123123', full_name: 'Teste') }

      it { expect { user.save }.to change(User, :count).by(1) }
    end
    
    context "when invalid" do
      let(:user) { User.new(email: 'test@test.com', full_name: 'Teste') }

      it { expect { user.save }.to change(User, :count).by(0) }
    end
  end

  describe "#destroy" do
    let!(:user) { User.create(email: 'test@test.com', password: '123123', full_name: 'Teste') }

    it { expect { user.destroy }.to change(User, :count).by(-1) }
  end

  describe "#update" do
    context "when valid" do
      let!(:user) { User.create(email: 'test@test.com', password: '123123', full_name: 'Teste') }

      it { expect { user.update(full_name: 'Test2') }.to change(user, :full_name) }
    end
    
    context "when invalid" do
      let(:user) { User.create(email: 'test@test.com', password: '123123', full_name: 'Teste') }

      it { expect { user.update(email: '') }.not_to change(user, :full_name) }
    end
  end
end
