class Product::ProductsController < ApplicationController
  before_action :set_product_product, only: %i[ show edit update destroy product_images add_product_images destroy_product_image]
  before_action :set_categories, only: %i[ show ]

  # GET /product/products or /product/products.json
  def index
    @product_products = ::Product.all.sort_by { |p| p.updated_at }.reverse
  end

  # GET /product/products/1 or /product/products/1.json
  def show
  end

  # GET /product/products/new
  def new
    @product_product = ::Product.new
  end

  # GET /product/products/1/edit
  def edit
  end

  # POST /product/products or /product/products.json
  def create
    thumbnail = product_product_params[:thumbnail].empty? ? "https://st2.depositphotos.com/52259964/50518/v/600/depositphotos_505187218-stock-illustration-mystery-black-box-isometric-icon.jpg" : product_product_params[:thumbnail]
    @product_product = ::Product.new(
      title: product_product_params[:title],
      description: product_product_params[:description],
      stock: product_product_params[:stock],
      discountPercentage: product_product_params[:discountPercentage],
      price: Money.from_cents(product_product_params[:price].to_i, "USD"),
      thumbnail: thumbnail
    )

    respond_to do |format|
      if @product_product.save
        Historical.create(admin: current_admin, movement: @product_product, change: :created)
        format.html { redirect_to product_product_url(@product_product), notice: { message: "Product was successfully created.", status: true } }
        format.json { render :show, status: :created, location: @product_product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product/products/1 or /product/products/1.json
  def update
    respond_to do |format|

      thumbnail = product_product_params[:thumbnail].empty? ? @product_product.thumbnail : product_product_params[:thumbnail]
      @product_product.assign_attributes(
        title: product_product_params[:title],
        description: product_product_params[:description],
        stock: product_product_params[:stock],
        discountPercentage: product_product_params[:discountPercentage],
        price: Money.from_cents(product_product_params[:price].to_i, "USD"),
        thumbnail: thumbnail
      )

      if @product_product.save!
        Historical.create(admin: current_admin, movement: @product_product, change: :edit)
        format.html { redirect_to product_product_url(@product_product), notice: { message: "Product was successfully updated.", status: true } }
        format.json { render :show, status: :ok, location: @product_product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product_product.errors, status: :unprocessable_entity }
      end
    end
  end

  def product_images; end

  def add_product_images
    respond_to do |format|
      if @product_product.pictures.attach(params[:pictures])
        Historical.create(admin: current_admin, movement: @product_product, change: :added_images)
        format.html { redirect_to product_images_product_product_path(id: @product_product.id), notice: { message: "Image added success.", status: true } }
        format.json { render :product_images, status: :ok, location: @product_product }
      else
        format.html { redirect_to product_images_product_product_path(id: @product_product.id), notice: { message: "Image added faild.", status: false } }
      end
    end
  end

  def destroy_product_image
    respond_to do |format|
      if @product_product.pictures.find(params[:picture_id]).purge
        Historical.create(admin: current_admin, movement: @product_product, change: :remove_image)
        format.html { redirect_to product_images_product_product_path(id: @product_product.id), notice: { message: "Image remove success.", status: true } }
        format.json { render :product_images, status: :ok, location: @product_product }
      else
        format.html { redirect_to product_images_product_product_path(id: @product_product.id), notice: { message: "Image remove faild.", status: false } }
      end
    end

  end
  # DELETE /product/products/1 or /product/products/1.json
  def destroy
    @product_product.destroy

    respond_to do |format|
      format.html { redirect_to product_products_url, notice: { message: "Product was successfully destroyed.", status: true } }
      format.json { head :no_content }
    end
  end

  private

  def set_categories
    @categories = Category.where.not(id: Category.joins(:product_categories).where(product_categories: { product: @product_product }))
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_product_product
    @product_product = ::Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_product_params
    params.permit(:title, :description, :discountPercentage, :price, :stock, :thumbnail)
  end

end
