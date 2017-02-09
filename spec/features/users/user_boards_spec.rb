require 'rails_helper'

describe 'User can see' do
  it 'all their Boards' do
    user = create(:registered_user)
    create_list(:board, 3, registered_user: user)
    visit registered_users_boards_path(user.pinspiration_credentials.first.username)
    
    user.boards.each do |board|
      expect(page).to have_content(board.name)
    end
  end
end
