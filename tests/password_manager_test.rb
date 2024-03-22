require 'minitest/autorun'
require_relative '../lib/password_manager'

class PasswordManagerTest < Minitest::Test
  def setup
    @password_manager = PasswordManager.new("master_password")
  end

  def test_add_and_retrieve_account
    @password_manager.add_account("gmail", "user@gmail.com", "password123")
    account = @password_manager.retrieve_account("gmail")
    assert_equal({ username: "user@gmail.com", password: "password123" }, account)
  end

  def test_retrieve_nonexistent_account
    account = @password_manager.retrieve_account("nonexistent_account")
    assert_nil(account)
  end
end
