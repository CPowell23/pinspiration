module ApplicationHelper
  def page_is_not_login_or_create?
    !page_is_login_or_create?
  end

  def page_is_login_or_create?
    current_uri(request) == "/login" || current_uri(request) == "/pinspiration_credentials/new"
  end

  def current_uri(request)
    request.env['PATH_INFO']
  end

  def board_class
    return "active" if current_uri(request) == "/#{params["username"]}" || current_uri(request) == "/#{params["username"]}/boards"
    "inactive"
  end

  def pin_class
    return "active" if current_uri(request) == "/#{params["username"]}/pins"
    "inactive"
  end

  def like_class
    return "active" if current_uri(request) == "/#{params["username"]}/likes"
    "inactive"
  end
end
