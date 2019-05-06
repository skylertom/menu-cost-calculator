class ServiceGenerator < Rails::Generators::Base
  argument :name, required: true, desc: "Service Object name, e.g: button"

  def create_app_file
    create_file "app#{general_path}.rb" do
      "class #{name.camelize} < ApplicationService\n" \
      "\tdef initialize\n" \
      "\tend\n" \
      "end"
    end
  end

  def create_test_file
    create_file "spec#{general_path}_spec.rb" do
      "require 'spec_helper'\n" \
      "\n" \
      "describe #{name.camelize} do\n" \
      "end"
    end
  end

  protected

  def general_path
    "/services/#{name.underscore}"
  end
end
