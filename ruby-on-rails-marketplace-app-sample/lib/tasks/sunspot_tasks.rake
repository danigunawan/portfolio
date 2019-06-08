# This task can be used reindex Solr without dropping your index first.
# This is ideal for production environments where a live, working index is critical.
#
# Put this in lib/tasks/sunspot_tasks.rake

namespace :sunspot do
  task reindex_gracefully: :environment do
    Dir.glob(Rails.root.join('app/models/**/*.rb')).each { |path| require path }
    sunspot_models = Sunspot.searchable

    index_options = { :batch_commit => false }

    begin
      require 'progress_bar'
      total_documents = sunspot_models.map { | m | m.count }.sum
      index_options[:progress_bar] = ProgressBar.new(total_documents)
    rescue LoadError => e
      $stdout.puts "Skipping progress bar: for progress reporting, add gem 'progress_bar' to your Gemfile"
    rescue Exception => e
      $stderr.puts "Error using progress bar: #{e.message}"
    end

    sunspot_models.each do |model|
      model.solr_index index_options
    end
  end
end
