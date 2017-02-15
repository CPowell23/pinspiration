require 'rails_helper'

RSpec.describe DeveloperCredential, type: :model do
  it { is_expected.to belong_to(:registered_user) }
end
