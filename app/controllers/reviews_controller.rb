class ReviewsController < ApplicationController
  before_action :set_reviewable
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  # GET /destinations/:destination_id/reviews
  # GET /hotels/:hotel_id/reviews
  # GET /tours/:tour_id/reviews
  def index
    @reviews = @reviewable.reviews.recent.includes(:user)
    
    respond_to do |format|
      format.html
      format.json { render json: @reviews, include: :user }
    end
  end

  # GET /destinations/:destination_id/reviews/:id
  def show
    respond_to do |format|
      format.html
      format.json { render json: @review, include: :user }
    end
  end

  # GET /destinations/:destination_id/reviews/new
  def new
    @review = @reviewable.reviews.build
  end

  # GET /destinations/:destination_id/reviews/:id/edit
  def edit
  end

  # POST /destinations/:destination_id/reviews
  def create
    @review = @reviewable.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      respond_to do |format|
        format.html { redirect_to [@reviewable, @review], notice: 'Avaliação criada com sucesso.' }
        format.json { render json: @review, status: :created }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { errors: @review.errors }, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /destinations/:destination_id/reviews/:id
  def update
    return head :forbidden unless @review.user == current_user

    if @review.update(review_params)
      respond_to do |format|
        format.html { redirect_to [@reviewable, @review], notice: 'Avaliação atualizada com sucesso.' }
        format.json { render json: @review }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: { errors: @review.errors }, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /destinations/:destination_id/reviews/:id
  def destroy
    return head :forbidden unless @review.user == current_user

    @review.destroy
    respond_to do |format|
      format.html { redirect_to polymorphic_path([@reviewable, :reviews]), notice: 'Avaliação removida com sucesso.' }
      format.json { head :no_content }
    end
  end

  private

  def set_reviewable
    if params[:destination_id]
      @reviewable = Destination.find(params[:destination_id])
    elsif params[:hotel_id]
      @reviewable = Hotel.find(params[:hotel_id])
    elsif params[:tour_id]
      @reviewable = Tour.find(params[:tour_id])
    end
  end

  def set_review
    @review = @reviewable.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment, :title)
  end
end