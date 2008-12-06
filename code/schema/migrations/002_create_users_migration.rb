migration 2, :create_users  do
  up do
    create_table :users do
      column :id,               Integer, :serial => true
      column :login,            String
      column :crypted_password, String
      column :salt,             String
      column :created_at,       DateTime
      column :updated_at,       DateTime
    end
  end
  
  down do
    drop_table :users
  end
end
