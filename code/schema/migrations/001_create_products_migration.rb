migration 1, :create_products  do
  up do
    create_table :products do
      column :id,         Integer, :serial => true
      column :name,       String
      column :sku,        String
      column :aisle,      String
      column :bin,        String
      column :inventory,  Integer
      column :created_at, DateTime
      column :updated_at, DateTime
    end
  end
  
  down do
    drop_table :products
  end
end
