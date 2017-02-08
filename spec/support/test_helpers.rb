module TestHelpers
  def stub_log_in_admin(admin)
    page.set_rack_session(admin_id: admin.id)
  end
end
