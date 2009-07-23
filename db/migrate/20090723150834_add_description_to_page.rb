class AddDescriptionToPage < ActiveRecord::Migration
  def self.up
    add_column :pages, :description, :string, :null => false, :default => ""
  end

  def self.down
    remove_column :pages, :description
  end
end
