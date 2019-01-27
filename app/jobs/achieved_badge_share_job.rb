class AchievedBadgeShareJob < ApplicationJob
  queue_as :default

  def perform(achieved_id)
    r = ImageProcessor::Badge.new(achieved_id)
    q = AchievedBadge.find achieved_id
    q.image_result = File.open(r.result_path)
    q.save
    r.remove_tmp_image
  end
end
