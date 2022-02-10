class CocktailsController < ApplicationController
  def index
    if params[:query].present?
      @query = params[:query]
      @cocktails = Cocktail.where('name ILIKE ?', "%#{params[:query]}%")
    else
      @cocktails = Cocktail.all
    end
  end

  def show
    @cocktail = Cocktail.find(params[:id])
  end

  def new
    @cocktail = Cocktail.new
    @dose = Dose.new
  end

  def create
    @cocktails = Cocktail.all
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def edit
    @cocktail = Cocktail.find(params[:id])
  end

  def update
    @cocktail = Cocktail.find(params[:id])
    if params[:cocktail][:photo].present?
      @cocktail.photo.attach(photo)
    end
    @cocktail.update(update_params)
    redirect_to cocktail_path(@cocktail)
  end

  def destroy
    @cocktail = Cocktail.find(params)
    @cocktail.desctroy
    redirect_to cocktails_path
  end

  private

  def cocktail_params
    params.require('cocktail').permit(:name, :instruction, :photo)
  end

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end
end
