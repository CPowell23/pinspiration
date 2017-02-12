module TestHelpers
  def stub_log_in_admin(admin)
    page.set_rack_session(admin_id: admin.id)
  end

  def stub_log_in_user(user)
    page.set_rack_session(registered_user_id: user.id)
  end
end
