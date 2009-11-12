class TimelineEvent < ActiveRecord::Base
  belongs_to :user
  belongs_to :source,             :polymorphic => true

  default_scope :order => "created_at DESC"
  named_scope :latest, lambda { |n| { :limit => n, :order => 'created_at desc' } }

  include BaseTimelineEvent
  is_a_timeline
end
