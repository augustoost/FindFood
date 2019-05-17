class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  # GET /restaurants
  # GET /restaurants.json
  def index
    @restaurants = Restaurant.all
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
  end

  def search_dish(term)
    $dish = term
  end

  def homepage
    @restaurant = Restaurant.all.order("name")

    @restaurant = @restaurant.joins("INNER JOIN dishes ON dishes.restaurant_id = restaurants.id INNER JOIN categories ON categories.id = dishes.category_id  and UPPER(categories.description) like", "'%#{params[:search_term1].to_s.upcase}%'") unless params[:search_term1].blank?

    @restaurant = @restaurant.joins("INNER JOIN dishes ON dishes.restaurant_id = restaurants.id AND UPPER(dishes.description) like ", "'%#{params[:search_term2].to_s.upcase}%'") unless params[:search_term2].blank?

    @restaurant = @restaurant.joins("INNER JOIN dishes ON dishes.restaurant_id = restaurants.id AND dishes.category_id = ", params[:category_id]).distinct unless params[:category_id].blank?

    search_dish(params[:search_term2].to_s)
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def restaurant_info
    @restaurant = Restaurant.find(params[:restaurant_id])

    @dishes = Dish.where("restaurant_id = ?", params[:restaurant_id])
    @search = $dish
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully created.' }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully updated.' }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { render :edit }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    @restaurant.destroy
    respond_to do |format|
      format.html { redirect_to restaurants_url, notice: 'Restaurant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :phone)
  end
end
