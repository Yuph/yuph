class Ability
  include CanCan::Ability

  def initialize(user)
    # Users
    can :read, User
    can :create, User

    # Ideas
    can :read, Idea
    can :create, Idea

    # Idea Comments
    can :read, IdeaComment

    # Post comments
    can :read, Post

    # User comments
    can [:index, :read], UserComment

    # Forum
    can :read, Forum

    # Categories
    can :read, Category

    # Abilities for logged users
    if user
      # Admin
      can :manage, :all if user.admin?

      # Users
      can [:update, :destroy], User.where(:id => user.try(:id))

      # Post
      can [:update, :destroy], Post, :user => {:id => user.try(:id) }
      can [:update, :destroy], Post do |post|
        post.category.forum.idea.users.include? user
      end
      can :create, Post, :category => {:forum_id => user.ideas.map(&:forum).map(&:id) }

      # Ideas
      can [:update, :destroy], Idea do |idea|
        user.ideas.include? idea
      end

      # Categories
      can [:create, :update, :destroy], Category, :forum => {:idea_id => user.ideas.map(&:id) }

      # User comments
      can :create, UserComment
      can :destroy, UserComment, :comment_sender_id => user.try(:id)
      can :read, UserComment do |c|
        [c.comment_receiver, c.comment_sender].include? user
      end

      # Idea comments
      can :create, IdeaComment, :idea => {:id => user.ideas }
      can [:update, :destroy], IdeaComment, { :idea_id => user.try(:ideas) }
      can [:update, :destroy], IdeaComment, { :user_id => user.try(:id) }

      # Follows
      can :create, Follow
    end

  end
end
