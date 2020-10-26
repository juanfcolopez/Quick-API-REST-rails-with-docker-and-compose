class AnimalsController < ApplicationController
  before_action :set_animal, only: [:show, :edit, :update, :destroy]

  # GET /animals
  # GET /animals.json
  def index
    animals = Animal.all
    render json: animals
  end

  # GET /animals/1
  # GET /animals/1.json
  def show
    render json: @animal
  end

  # GET /animals/new
  def new
    animal = Animal.new
    render json: animal
  end

  # GET /animals/1/edit
  def edit
  end

  # POST /animals
  # POST /animals.json
  def create
    animal = Animal.new(animal_params)
    if animal.save
      render json: animal, status: :created
    else
      render json: {}, status: :bad_request
    end
  end

  # PATCH/PUT /animals/1
  # PATCH/PUT /animals/1.json
  def update
   
    if @animal.update(animal_params)
      render json: @animal
    else
      render json: {}, status: :bad_request 
    end
  end

  # DELETE /animals/1
  # DELETE /animals/1.json
  def destroy
    @animal.destroy
    render json: {}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_animal
      @animal = Animal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def animal_params
      params.require(:animal).permit(:name)
    end
end
