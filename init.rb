require 'redmine'

require_relative 'lib/computed_custom_field/custom_field_patch'
require_relative 'lib/computed_custom_field/custom_fields_helper_patch'
require_relative 'lib/computed_custom_field/model_patch'
require_relative 'lib/computed_custom_field/issue_patch'
require_relative 'lib/computed_custom_field/hooks'

Redmine::Plugin.register :computed_custom_field do
  name 'Computed custom field'
  author 'Yakov Annikov'
  url 'https://github.com/annikoff/redmine_plugin_computed_custom_field'
  description ''
  version '1.0.7'
  settings default: {}
end

RedmineApp::Application.configure do
  config.after_initialize do
    models = [
      Enumeration, Group, Issue, Project,
      TimeEntry, User, Version
    ]
    models.each do |model|
      if model.included_modules
              .exclude?(ComputedCustomField::ModelPatch)
        model.send :include, ComputedCustomField::ModelPatch
      end
    end
  end
end
