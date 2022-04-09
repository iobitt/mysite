class TagsController < ApplicationController

  def index; end

  def new
    @tag = @current_user.tags.new
  end

  def create
    @tag = @current_user.tags.new(tag_params)

    if @tag.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def tag
    @tag ||= @current_user.tags.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end

