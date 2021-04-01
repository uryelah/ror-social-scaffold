# rubocop:disable Layout/LineLength
# rubocop:disable Style/GuardClause
module FriendshipsHelper
  def verify_friendship(friend_id)
    Friendship.where('(user_id = ? and friend_id = ?) OR (user_id = ? and friend_id = ?)',
                     current_user.id, friend_id, friend_id, current_user.id).first
  end

  def friendship_button(user)
    friendship = verify_friendship(user)
    if current_user != user
      if friendship.nil?
        content_tag(:div,
                    (button_to 'Invite to be friends',
                               friendships_path(params: { friendship: { friend_id: user.id, user_id: current_user.id } }),
                               method: :post, class: 'button-friendship'), class: 'button-friendship')
      elsif friendship.confirmed
        'Already Friends'
      elsif friendship.user_id == user.id
        content_tag(:div, (button_to 'Accept Friendship', friendship_path(friendship.id), method: :put) +
                            (button_to 'Reject Friendship', friendship_path(friendship.id), method: :delete))
      else
        content_tag(:p, 'Pending Response', class: 'button-friendship status pending')
      end
    end
  end
end
# rubocop:enable Layout/LineLength
# rubocop:enable Style/GuardClause
