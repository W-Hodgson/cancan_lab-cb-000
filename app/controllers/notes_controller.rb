class NotesController < ApplicationController
  def new
  end

  def create
    note = Note.new(note_params)
    note.user = current_user
    note.save!
    redirect_to '/'
  end

  def edit
  end

  def update
    @note.update(note_params)
    redirect_to '/'
  end

  def index
    @notes = Note.none
    if current_user
      @notes = current_user.readable
    end
  end

  def show
  end

  def destroy
  end

  private

    def note_params
      params.require(:note).permit(:content, :visible_to)
    end
end
