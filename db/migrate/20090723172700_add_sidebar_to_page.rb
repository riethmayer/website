class AddSidebarToPage < ActiveRecord::Migration
  def self.up
    add_column :pages, :sidebar, :text
    add_column :pages, :sidebar_class, :string, :null => false, :default => 'yui-t7'
  end

  def self.down
    remove_column :pages, :sidebar_class
    remove_column :pages, :sidebar
  end
end
