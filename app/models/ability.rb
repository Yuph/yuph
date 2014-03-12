class Ability
  include CanCan::Ability

  def initialize(user)
    # Users
    can :read, User
    can :create, User

    can [:update, :destroy], User.where(:id => user.try(:id))

    # Ideas
    can :read, Idea
    can :create, Idea

    can [:update, :destroy], Idea do |idea|
      user.ideas.include? idea
    end

    # Idea Comments
    can :read, IdeaComment
    can :create, IdeaComment
    can [:update, :destroy], IdeaComment, ['idea_id = ?', user.try(:ideas)]
    can [:update, :destroy], IdeaComment, ['user_id = ?', user.try(:id)]

    # Post comments
    can :read, Post
    can :manage, Post, :user => {:user_id => user.try(:id) }
    can :manage, Post do |post|
      post.category.forum.idea.users.include? user
    end

    # User comments
    can :index, UserComment
    can :create, UserComment if user

    can :destroy, UserComment, :comment_sender_id => user.try(:id)
    can :read, UserComment do |c|
      [c.comment_receiver, c.comment_sender].include? user
    end

    # Forum
    can :read, Forum

    # Categories
    can :read, Category
    if user
      can [:create, :update, :destroy], Category, :forum => {:idea_id => user.ideas.map(&:id) }
    end

    # Follows
    can :create, Follow

  end
end
