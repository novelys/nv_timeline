class CreateTimelineEvents < ActiveRecord::Migration
  def self.up
    create_table :timeline_events do |t|
      t.references :user
      t.references :source, :polymorphic => { :default => 'User' }
      t.string :body
      t.string :type
      t.timestamps
    end
    add_index :timeline_events, :user_id
    add_index :timeline_events, [:source_type, :source_id], :name => "idx_timeline_events_source"
  end
 
  def self.down
    remove_index :timeline_events, :name => :idx_timeline_events_source
    remove_index :timeline_events, :user_id
    drop_table :timeline_events
  end
end
 

