class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new

    can [:edit, :destroy], Post do |post|
      post.user == user
    end

    # define abilities to prevent users from liking their own questions
    can :like, Post do |post|
      user != post.user
    end
    cannot :like, Post do |post|
      user == post.user
    end
  end

end
