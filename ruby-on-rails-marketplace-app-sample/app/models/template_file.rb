class TemplateFile < ActiveRecord::Base
	validates :body,    :presence => true
	validates :path,    :presence => true
	validates :format,  :inclusion => Mime::SET.symbols.map(&:to_s)
	validates :locale,  :inclusion => I18n.available_locales.map(&:to_s), :allow_blank => true
	validates :handler, :inclusion => ActionView::Template::Handlers.extensions.map(&:to_s)

	after_save { TemplateResolver.instance.clear_cache }

	belongs_to :site

	def self.find_model_templates(conditions = {})
		self.where(conditions)
	end

	def self.resolver(options={})
		TemplateResolver.using self, options
	end
end
