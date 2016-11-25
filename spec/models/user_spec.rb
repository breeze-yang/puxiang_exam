require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validate token' do
    it 'authenticated' do
      user = create :user
      user.remember
      expect(user.authenticated? :remember, user.remember_token).to be_truthy
    end

    it 'unauthenticated' do
      user = create :user
      user.remember
      expect(user.authenticated? :remember, 'token').to be_falsey
    end
  end

  describe 'Validate user parameters' do
    let(:user) do
      User.new(username: "Example User", email: "user@example.com",
               password: "password", password_confirmation: "password")
    end

    it 'should be valid' do
      expect(user.valid?).to be_truthy
    end

    it 'should Successful update' do
      user.save
      user.username = 'example_name'
      expect(user.save).to be_truthy
    end

    it 'should be valid' do
      user.password_confirmation = nil
      expect(user.valid?).to be_truthy
    end

    it 'email validation should reject invalid addresses' do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        user.email = invalid_address
        expect(user.valid?).to be_falsey
      end
    end

    it 'email should be unique' do
      duplicate_user = user.dup
      user.save
      duplicate_user.username = 'test'
      expect(duplicate_user.save).to be_falsey
      expect(duplicate_user.errors[:email].blank?).to be_falsey
    end

    it 'username should be unique' do
      duplicate_user = user.dup
      user.save
      duplicate_user.email = 'test@qq.com'
      expect(duplicate_user.save).to be_falsey
      expect(duplicate_user.errors[:username].blank?).to be_falsey
    end

  end
end
