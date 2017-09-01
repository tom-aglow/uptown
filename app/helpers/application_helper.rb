module ApplicationHelper
  def error_messages_for(object)
    render(partial: 'layouts/public/error_messages', locals: {object: object})
  end
end
