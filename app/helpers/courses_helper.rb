module CoursesHelper
  # Acción principal de la tarjeta de curso. styles.md §6.1: una sola por
  # tarjeta, y §6.3: el texto de un botón empieza por verbo.
  #
  # La lógica de estados es la de siempre; lo que cambia es que cada rama
  # devuelve un elemento del sistema en lugar de HTML suelto con estilos inline.
  def enrollment_button(course)
    return link_to('See price', new_course_enrollment_path(course), class: 'btn btn-primary w-100') unless current_user

    if course.user == current_user
      link_to 'Manage course', course_path(course), class: 'btn btn-outline-primary w-100'
    elsif course.enrollments.where(user: current_user).any?
      link_to course_path(course), class: 'btn btn-primary w-100' do
        safe_join([tag.i(class: 'fa fa-play', 'aria-hidden': 'true'), 'Continue'], ' ')
      end
    elsif course.price.positive?
      link_to "Enroll · #{number_to_currency(course.price)}", new_course_enrollment_path(course), class: 'btn btn-primary w-100'
    else
      link_to 'Enroll for free', new_course_enrollment_path(course), class: 'btn btn-primary w-100'
    end
  end

  # Progreso del alumno en el curso, o nil si no está inscrito.
  # styles.md §6.5: la barra siempre va acompañada de su etiqueta textual.
  def course_progress(course)
    return unless current_user && course.enrollments.where(user: current_user).any?

    course.progress(current_user).to_i
  end

  # Invitación a valorar, o acuse de que ya se valoró. Devuelve nil si el
  # usuario no está inscrito, que es cuando no procede pedir nada.
  def review_button(course)
    return unless current_user

    enrollment = course.enrollments.where(user: current_user).first
    return if enrollment.nil?

    if course.enrollments.where(user: current_user).pending_review.any?
      link_to edit_enrollment_path(enrollment), class: 'btn btn-outline-primary btn-sm w-100' do
        safe_join([tag.i(class: 'fa fa-star', 'aria-hidden': 'true'), 'Rate this course'], ' ')
      end
    else
      link_to enrollment_path(enrollment), class: 'el-meta d-inline-flex align-items-center gap-1' do
        safe_join([tag.i(class: 'fa fa-check', 'aria-hidden': 'true'), 'You rated this course'], ' ')
      end
    end
  end

  # El certificado solo existe al 100%. Antes de eso se dice cuándo llega, en
  # lugar de mostrar un enlace muerto.
  def certificate_button(course)
    return unless current_user

    enrollment = course.enrollments.where(user: current_user).first
    return if enrollment.nil?

    if course.progress(current_user) == 100
      link_to certificate_enrollment_path(enrollment, format: :pdf), class: 'btn btn-outline-primary btn-sm w-100' do
        safe_join([tag.i(class: 'fa fa-file-pdf', 'aria-hidden': 'true'), 'Download certificate'], ' ')
      end
    else
      tag.span 'Certificate available once you finish', class: 'el-meta'
    end
  end

  # Píldoras de estado del curso. styles.md §6.2: el estado se nombra desde el
  # usuario ("Waiting for review"), no desde la columna de la base de datos.
  def course_status_pills(course)
    pills = []
    pills << if course.published?
               tag.span('Published', class: 'el-pill el-pill--success')
             else
               tag.span('Draft', class: 'el-pill el-pill--muted')
             end
    pills << if course.approved?
               tag.span('Approved', class: 'el-pill el-pill--success')
             else
               tag.span('Waiting for review', class: 'el-pill el-pill--warning')
             end
    safe_join(pills, ' ')
  end
end
