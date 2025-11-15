# spec/controllers/reviews_controller_spec.rb
require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let(:user) { create(:user) }
  let(:destination) { create(:destination) }
  let(:valid_attributes) { { rating: 5, comment: 'Excelente!', title: 'Adorei' } }
  let(:invalid_attributes) { { rating: nil, comment: 'Sem rating' } }

  before { sign_in user }

  describe 'GET #index' do
    context 'for destination' do
      let!(:reviews) { create_list(:review, 3, reviewable: destination) }

      it 'returns a success response' do
        get :index, params: { destination_id: destination.id }
        expect(response).to be_successful
      end

      it 'assigns @reviews' do
        get :index, params: { destination_id: destination.id }
        expect(assigns(:reviews)).to match_array(reviews)
      end

      it 'renders json when requested' do
        get :index, params: { destination_id: destination.id, format: :json }
        expect(response.content_type).to include('application/json')
      end
    end

    context 'for hotel' do
      let(:hotel) { create(:hotel) }
      let!(:reviews) { create_list(:review, 2, reviewable: hotel) }

      it 'returns reviews for hotel' do
        get :index, params: { hotel_id: hotel.id }
        expect(assigns(:reviews)).to match_array(reviews)
      end
    end

    context 'for tour' do
      let(:tour) { create(:tour) }
      let!(:reviews) { create_list(:review, 2, reviewable: tour) }

      it 'returns reviews for tour' do
        get :index, params: { tour_id: tour.id }
        expect(assigns(:reviews)).to match_array(reviews)
      end
    end
  end

  describe 'GET #show' do
    let(:review) { create(:review, reviewable: destination) }

    it 'returns a success response' do
      get :show, params: { destination_id: destination.id, id: review.id }
      expect(response).to be_successful
    end

    it 'assigns @review' do
      get :show, params: { destination_id: destination.id, id: review.id }
      expect(assigns(:review)).to eq(review)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Review' do
        expect {
          post :create, params: { destination_id: destination.id, review: valid_attributes }
        }.to change(Review, :count).by(1)
      end

      it 'assigns the review to current user' do
        post :create, params: { destination_id: destination.id, review: valid_attributes }
        expect(assigns(:review).user).to eq(user)
      end

      it 'redirects to the created review' do
        post :create, params: { destination_id: destination.id, review: valid_attributes }
        expect(response).to redirect_to([destination, Review.last])
      end

      context 'with JSON format' do
        it 'returns created status' do
          post :create, params: { destination_id: destination.id, review: valid_attributes, format: :json }
          expect(response).to have_http_status(:created)
        end
      end
    end

    context 'with invalid params' do
      it 'does not create a new Review' do
        expect {
          post :create, params: { destination_id: destination.id, review: invalid_attributes }
        }.not_to change(Review, :count)
      end

      it 'returns unprocessable entity status' do
        post :create, params: { destination_id: destination.id, review: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      context 'with JSON format' do
        it 'returns errors' do
          post :create, params: { destination_id: destination.id, review: invalid_attributes, format: :json }
          json_response = JSON.parse(response.body)
          expect(json_response).to have_key('errors')
        end
      end
    end

    context 'when user already reviewed' do
      before { create(:review, user: user, reviewable: destination) }

      it 'does not create duplicate review' do
        expect {
          post :create, params: { destination_id: destination.id, review: valid_attributes }
        }.not_to change(Review, :count)
      end
    end
  end

  describe 'PUT #update' do
    context 'when user owns the review' do
      let(:review) { create(:review, user: user, reviewable: destination) }
      let(:new_attributes) { { rating: 3, comment: 'Mudei de ideia' } }

      it 'updates the review' do
        put :update, params: { destination_id: destination.id, id: review.id, review: new_attributes }
        review.reload
        expect(review.rating).to eq(3)
        expect(review.comment).to eq('Mudei de ideia')
      end

      it 'redirects to the review' do
        put :update, params: { destination_id: destination.id, id: review.id, review: new_attributes }
        expect(response).to redirect_to([destination, review])
      end
    end

    context 'when user does not own the review' do
      let(:other_user) { create(:user) }
      let(:review) { create(:review, user: other_user, reviewable: destination) }

      it 'returns forbidden' do
        put :update, params: { destination_id: destination.id, id: review.id, review: { rating: 1 } }
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when user owns the review' do
      let!(:review) { create(:review, user: user, reviewable: destination) }

      it 'destroys the review' do
        expect {
          delete :destroy, params: { destination_id: destination.id, id: review.id }
        }.to change(Review, :count).by(-1)
      end

      it 'redirects to reviews list' do
        delete :destroy, params: { destination_id: destination.id, id: review.id }
        expect(response).to redirect_to(destination_reviews_path(destination))
      end
    end

    context 'when user does not own the review' do
      let(:other_user) { create(:user) }
      let!(:review) { create(:review, user: other_user, reviewable: destination) }

      it 'returns forbidden' do
        delete :destroy, params: { destination_id: destination.id, id: review.id }
        expect(response).to have_http_status(:forbidden)
      end

      it 'does not destroy the review' do
        expect {
          delete :destroy, params: { destination_id: destination.id, id: review.id }
        }.not_to change(Review, :count)
      end
    end
  end
end