class Courses::CourseWizardController < ApplicationController
  include Wicked::Wizard
  before_action :set_progress, only: [:show, :update]
  before_action :set_course, only: [:show, :update, :finish_wizard_path]

  steps :basic_info, :details, :lessons, :publish

  #TODO add more wizards and change this views(update atributes)

  def show
    #@user = current_user
    #case step
    #when :find_friends
    #  @friends = @user.find_friends
    #end
    authorize @course, :edit?
    case step
    when :basic_info
    when :details
      @tags = Tag.all
    when :lessons
    when :publish
    end
    render_wizard
  end

  def update
    authorize @course, :edit?
    case step
    when :basic_info
    when :details
      @tags = Tag.all
    when :lessons
    when :publish
    end
    # Solo se asignan los atributos: render_wizard es quien guarda, y si el
    # guardado falla se queda en el paso actual con los errores. Llamar antes a
    # update suponía intentar el mismo guardado dos veces por envío.
    @course.assign_attributes(course_params)
    render_wizard @course
  end

  def finish_wizard_path
    #courses_path
    authorize @course, :edit?
    course_path(@course)
  end

  private
    def set_progress
      if wizard_steps.any? && wizard_steps.index(step).present?
        @progress = ((wizard_steps.index(step) + 1).to_d / wizard_steps.count.to_d) * 100
      else
        @progress = 0
      end
    end
    
    def set_course
      @course = Course.friendly.find params[:course_id]
    end

    def course_params
      permitted = params.require(:course).permit(:title, :description, :short_description, :price,
        :published, :language, :level, :avatar, tag_ids: [],
        lessons_attributes: [:id, :title, :content, :_destroy]
      )
      # tag_ids llega del select de selectize, que puede mandar identificadores
      # que ya no existen (una etiqueta borrada mientras se rellenaba el paso, o
      # una que el servidor rechazó al crearla). Asignar uno inexistente lanza
      # RecordNotFound y el paso respondía 404, así que se descartan.
      permitted[:tag_ids] = Tag.where(id: permitted[:tag_ids]).pluck(:id) if permitted.key?(:tag_ids)
      permitted
    end

end