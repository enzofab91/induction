json.messages @messages, partial: 'api/v1/messages/message', as: :message

json.next_page @messages.next_page
