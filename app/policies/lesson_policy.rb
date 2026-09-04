class LessonPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    @user.has_role?(:admin) || @record.course.user_id == @user.id || @record.course.bought?(@user)
  end

  def edit?
    @user.present? && @record.course.user_id == @user.id
  end

  def update?
    @record.course.user_id == @user.id
  end

  # Devolvía nil, con lo que cualquier authorize sobre el formulario de alta
  # habría denegado siempre. Quien puede crear la lección puede verlo.
  def new?
    create?
  end

  def create?
    @record.course.user_id == @user.id
  end

  def destroy?
    @record.course.user_id == @user.id
  end
end