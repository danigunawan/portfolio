require 'rails/generators/base'
# require 'app/models/market/listing/listing.rb'

module Market
	class ModelGenerator < Rails::Generators::Base
	  def create_initializer_file
	  	model_path = "app/models/market/listing/listing.rb"
	  	model_class_name = "Listing"

	  	inject_into_class(model_path, model_class_name, "#{indents}authenticates_with_sorcery!\n")
	  end

	  private

	  def indents
      "  " * (namespaced? ? 2 : 1)
    end
	end
end