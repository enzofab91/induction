class TargetsNearUserQuery
  def initialize(targets = Target.all)
    @targets = targets
  end

  def call(target)
    @targets = Target.within(target.radius, origin: [target.latitude, target.longitude])
                     .where(topic_id: target.topic_id)
                     .where.not(user_id: target.user_id)
  end
end
