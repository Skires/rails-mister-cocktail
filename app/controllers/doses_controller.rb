class DosesController < ApplicationController
    before_action :find_dose, only: [ :edit, :update, :edit, :show, :destroy]
    def index
      @doses = Dose.all
    end

    def show
    end

    def new
      @cocktail = Cocktail.find(params[:cocktail_id])
      @dose = Dose.new
    end

    def create # do with form
      @cocktail = Cocktail.find(params[:cocktail_id])
      @dose = Dose.new(dose_params)
      @dose.cocktail = @cocktail
      if @dose.save
        redirect_to cocktail_path(@cocktail)
      else
        render :new
      end
    end

    def dose_params
      params.require(:dose).permit(:description, :ingredient_id)
    end

    def edit
    end

    def update  # do with form
      find_dose
      if @dose.update(dose_params)
        redirect_to @dose, notice: 'dose was successfully updated.'
        # redirect_to dose_path
      else
        render :edit
      end
    end
    def destroy
      find_dose
      @dose.destroy
      # no need for app/views/doses/destroy.html.erb
      redirect_to doses_path
    end

    def find_dose
      @dose = Dose.find(params[:id])
    end
  end