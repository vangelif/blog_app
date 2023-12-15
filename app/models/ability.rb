# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(current_user)
    # Define abilities for the user here. For example:
    @user = current_user || User.new # for guest

    if @user.admin?
      can :manage, :all
    else
      can %i[read create], Comment
      can [:destroy], Comment, user_id: @user.id
      can %i[create destroy], Post, author_id: @user.id
      can :read, Post
    end
  end
end
