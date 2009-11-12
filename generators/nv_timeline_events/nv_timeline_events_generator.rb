class NvTimelineEventsGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      m.directory 'app/models/timeline_events'
      m.template 'model.rb.erb', "app/models/timeline_events/#{file_name}.rb"
      m.directory 'app/views/timeline_events'
      m.template 'view.haml.erb', "app/views/timeline_events/_#{file_name}.html.haml"
    end
  end
end
