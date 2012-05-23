class DeviseCreateAdminUsers < ActiveRecord::Migration
  def self.up
    create_table(:admin_users ) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable

      # t.encryptable
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable


      t.timestamps
    end

    # Create a default user, this account is just for me, after created, remember to forget me!
    AdminUser.create!(:email => 'master@inruby.com', :password => 'inruby', :password_confirmation => 'inruby')
    AdminUser.create!(:email => 'kenrome@gmail.com', :password => 'inruby', :password_confirmation => 'inruby')
    AdminUser.create!(:email => 'kenrome@163.com', :password => 'inruby', :password_confirmation => 'inruby')
    AdminUser.create!(:email => '406354072@qq.com', :password => 'inruby.com', :password_confirmation => 'inruby.com') #Tom
    AdminUser.create!(:email => '94445362@qq.com', :password => 'inruby.com', :password_confirmation => 'inruby.com') #wang dong

    add_index :admin_users, :email,                :unique => true
    add_index :admin_users, :reset_password_token, :unique => true
    # add_index :admin_users, :confirmation_token,   :unique => true
    # add_index :admin_users, :unlock_token,         :unique => true
    # add_index :admin_users, :authentication_token, :unique => true
  end

  def self.down
    drop_table :admin_users
  end
end
