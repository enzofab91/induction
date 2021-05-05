json.target @target, partial: 'api/v1/targets/info', as: :target

json.matches @target.matches, partial: 'api/v1/targets/match_info', as: :match

json.title I18n.t('api.notifications.new_match') if @target.matches
