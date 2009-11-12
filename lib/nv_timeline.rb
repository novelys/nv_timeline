module BaseTimelineEvent
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    
    def is_a_timeline
      named_scope :timelines, lambda { |object, options| { :conditions => self.condition_for_events(object, options) } }
    end
    
    # available options :
    #  * :with => [:groups, :friends, :self]
    #  * :except => [:groups]
    #  * :only => [:self, :friends]
    def find_events(object, options={})
      TimelineEvent.find(:all, :conditions => self.condition_for_events(object, options))
    end

    def condition_for_events(object, options={})
      sources = options[:with]
      sources -= options[:except] if options[:except].present?
      sources &= options[:only] if options[:only].present?
    
      conditions = ["1=2"]
      sources.each do |source|
        if source == :self
          conditions = self.for_item(object, conditions)
        else
          conditions = self.for_collection(object.send(source), conditions)
        end
      end 
      conditions
    end

    def for_item(source, conditions)
      if source.present?
        if source.kind_of? User
          self.for_user(source, conditions)
        else
          conditions[0] += ' OR (source_type = ? AND source_id = ?)'
          conditions << source.class.to_s << source.id
        end
      end
      conditions
    end

    def for_collection(sources, conditions)
      if sources.present? && sources.size > 0
        if sources.any? {|source| source.kind_of? User}
          self.for_users(sources, conditions)
        else
          ids = sources.map(&:id)
          conditions[0] += ' OR (source_type = ? AND source_id IN (?))'
          conditions << sources.first.class.to_s << ids
        end
      end
      conditions
    end

    def for_users(users, conditions)
      ids = users.map(&:id)
      conditions[0] += ' OR user_id IN (?) OR (source_type = ? AND source_id IN (?))'
      conditions << ids  << 'User' << ids
    end

    def for_user(user, conditions)
      conditions[0] += ' OR user_id = ? OR (source_type = ? AND source_id = ?)'
      conditions << user.id << 'User' << user.id
    end
  end
end

module ActiveRecord
  module NvTimeline
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def has_timeline(params={:with => []})
        params[:with] << :self unless params[:with] && params[:with].include?(:self)
        write_inheritable_attribute(:timeline_sources, (params[:with]))
        class_inheritable_reader :timeline_sources
        has_many :timeline_events, :as => :source
        include ActiveRecord::NvTimeline::InstanceMethods
      end
    end #module ClassMethods
    
    module InstanceMethods
      def timelines(options={})
        options[:with] ||= timeline_sources
        TimelineEvent.timelines(self, options)
      end
    end
  end #module HasVisibility
end #module ActiveRecord
