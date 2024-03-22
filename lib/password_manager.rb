require 'openssl'
require 'json'

class PasswordManager
  attr_accessor :accounts

  def initialize(master_password)
    @master_password = encrypt(master_password)
    @accounts = {}
  end

  def add_account(account_name, username, password)
    @accounts[account_name] = { username: username, password: encrypt(password) }
  end

  def retrieve_account(account_name)
    account = @accounts[account_name]
    return nil unless account

    { username: account[:username], password: decrypt(account[:password]) }
  end

  private

  def encrypt(data)
    cipher = OpenSSL::Cipher.new('aes-256-cbc')
    cipher.encrypt
    cipher.key = @master_password || OpenSSL::Random.random_bytes(32)
    encrypted = cipher.update(data) + cipher.final
    encrypted.unpack('H*')[0]
  end

  def decrypt(data)
    cipher = OpenSSL::Cipher.new('aes-256-cbc')
    cipher.decrypt
    cipher.key = @master_password
    decrypted = [data].pack('H*')
    cipher.update(decrypted) + cipher.final
  end
end
