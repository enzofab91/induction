class MatchForm < ApplicationForm
  attr_accessor :match_attributes

  def initialize(args)
    super(args)

    @models = [match]
  end

  def save
    return unless @match.save
    
    notify_match
    create_conversation
  end

  private

  def match
    @match ||= Match.new(match_attributes)
  end

  def notify_match
    second_user = match.second_user

    data = Hash(name: second_user.first_name, match_id: match.id)

    registration_ids = [second_user.push_token]

    FcmService.sent_notification(registration_ids, I18n.t('api.notifications.new_match'), data)
  end

  def create_conversation
    Conversation.create!(match_id: match.id)
  end
end
