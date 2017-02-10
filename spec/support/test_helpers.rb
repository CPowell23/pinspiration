module TestHelpers
  def stub_log_in_admin(admin)
    page.set_rack_session(admin_id: admin.id)
  end

  def stub_admin_logout(admin)
    page.set_rack_session(admin_id: nil)
  end

  def stub_log_in_user(user)
    page.set_rack_session(registered_user_id: user.id)
  end

  def stub_user_logout(user)
    page.set_rack_session(registered_user_id: nil)
  end
end
