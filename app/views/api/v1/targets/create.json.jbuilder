json.target @target, partial: 'api/v1/targets/info', as: :target

json.matches @target.matches, partial: 'api/v1/targets/match_info', as: :match
