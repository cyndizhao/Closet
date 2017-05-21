class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new

    can [:edit, :destroy], Post do |post|
      post.user == user
    end

    can :like, Post do |post|
      user != post.user
    end
    cannot :like, Post do |post|
      user == post.user
    end

    can :bookmark, Post do |post|
      user != post.user
    end
    cannot :bookmark, Post do |post|
      user == post.user
    end

  end

end
