class TagsController < ApplicationController
  
  def index
    @tags = Tag.all.order(course_tags_count: :desc)
    authorize @tags
  end
  
  # Lo llama selectize desde el paso "details" del asistente cuando el profesor
  # escribe una etiqueta que no está en la lista. Un nombre ya existente no es
  # un error para quien lo escribe: se le devuelve la etiqueta que ya hay, en
  # lugar de un JSON de errores que el navegador acababa mandando de vuelta
  # como tag_ids=undefined (y el curso respondía 404 al guardar el paso).
  def create
    name = tag_params[:name].to_s.strip
    @tag = Tag.where('LOWER(name) = ?', name.downcase).first || Tag.new(name: name)

    if @tag.persisted? || @tag.save
      render json: @tag
    else
      render json: { errors: @tag.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  def destroy
    @tag = Tag.find(params[:id])
    authorize @tag
    @tag.destroy
    redirect_to tags_path, notice: "Tag was successfully destroyed"
  end

  private

    def tag_params
      params.require(:tag).permit(:name)
    end
end 