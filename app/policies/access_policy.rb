class AccessPolicy
  include AccessGranted::Policy

  def configure
    # Example policy for AccessGranted.
    # For more details check the README at
    #
    # https://github.com/chaps-io/access-granted/blob/master/README.md
    #
    # Roles inherit from less important roles, so:
    # - :admin has permissions defined in :member, :guest and himself
    # - :member has permissions from :guest and himself
    # - :guest has only its own permissions since it's the first role.
    #
    # The most important role should be at the top.
    # In this case an administrator.
    #
    role :admin, proc { |user| user != nil && user.admin? } do
      can [:index, :destroy, :block, :update], User
      can [:index, :destroy, :update, :create], Instruction
      can [:index, :destroy, :update, :create], Step
      can [:index, :destroy, :update, :create], Block
    end

    # More privileged role, applies to registered users.
    #
    role :member, proc { |user| user != nil } do
      can [:change_theme,  :show_profile], User

      can [:update], User do |user_obj, user|
        user_obj == user
      end
      can [:update, :destroy], Instruction do |instruction, user|
        instruction.user == user
      end

      can [:update,:destroy], Step do |step, user|
        step.instruction.user == user
      end

      can [:update, :destroy], Block do |block,user|
        block.step.instruction.user == user
      end

      can :create, Instruction
    end

    # The base role with no additional conditions.
    # Applies to every user.
    #
    role :guest do
      can [:index, :show], Instruction
      can [:index, :show], Step
      can :index, Block
      can :show, Tag
      can [:index], User
    end
  end
end
