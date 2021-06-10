class TargetsCleanupJob < ApplicationJob
  queue_as :default

  after_perform do |job|
    self.class.set(wait: 7.days).perform_later(job.arguments)
  end

  def perform
    Target.find_each do |target|
      target.destroy! if target.expired?
    end
  end
end
