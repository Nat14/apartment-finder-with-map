class ApartmentsController < ApplicationController
  before_action :set_apartment, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /apartments
  # GET /apartments.json
  def index
    @apartments = Apartment.all
  end

  # GET /apartments/1
  # GET /apartments/1.json
  def show
  end

  # GET /apartments/new
  def new
    if user_signed_in?
      @apartment = current_user.apartments.new
    else
      redirect_to apartments_path
    end
  end

  # GET /apartments/1/edit
  def edit
  end

  def show
    @apartment = Apartment.find(params[:id])
      @hash = Gmaps4rails.build_markers(@apartment) do |apartment, marker|
        marker.lat apartment.latitude
        marker.lng apartment.longitude
        marker.infowindow apartment.address
      end
  end

  # POST /apartments
  # POST /apartments.json
  def create
    @apartment = current_user.apartments.new(apartment_params)

    respond_to do |format|
      if @apartment.save
        format.html { redirect_to @apartment, notice: 'Apartment was successfully created.' }
        format.json { render :show, status: :created, location: @apartment }
      else
        format.html { render :new }
        format.json { render json: @apartment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /apartments/1
  # PATCH/PUT /apartments/1.json
  def update
    respond_to do |format|
      if @apartment.update(apartment_params)
        format.html { redirect_to @apartment, notice: 'Apartment was successfully updated.' }
        format.json { render :show, status: :ok, location: @apartment }
      else
        format.html { render :edit }
        format.json { render json: @apartment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apartments/1
  # DELETE /apartments/1.json
  def destroy
    @apartment.destroy
    respond_to do |format|
      format.html { redirect_to apartments_url, notice: 'Apartment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_apartment
      @apartment = Apartment.find(params[:id])
      if !user_signed_in? || current_user.id != @apartment.user.id
        redirect_to new_user_session_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def apartment_params
      params.require(:apartment).permit(:latitude, :longitude, :address, :name, :contact, :image)
    end
end
