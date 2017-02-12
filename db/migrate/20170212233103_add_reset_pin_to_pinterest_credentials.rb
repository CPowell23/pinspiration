class AddResetPinToPinterestCredentials < ActiveRecord::Migration[5.0]
  def change
    add_column(:pinspiration_credentials, :reset_pin, :integer)
  end
end
