class ModelTaskJob < ActiveJob::Base
  queue_as :default

  def perform(model, task)
    if model
      model.reload
      model.send(task) if model.respond_to? task
    end
  end
end
