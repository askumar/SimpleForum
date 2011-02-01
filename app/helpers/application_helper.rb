# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def error_messages(target)
    return if target.nil?
    return if target.errors.empty?
    html = '<div id="errorExplanation">'
    html += '<h2>' + pluralize(target.errors.count, 'error') + ' prohibited this ' + target.class.to_s + ' from being saved:</h2>'
    html += '<ul>'
    target.errors.full_messages.each { |msg| html += '<li>' + msg + '</li>' }
    html += '</ul></div>'
    return raw html
  end

end
