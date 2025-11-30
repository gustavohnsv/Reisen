# spec/models/review_spec.rb
require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'associations' do
    it { should belong_to(:reviewable) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    subject { build(:review) }

    it { should validate_presence_of(:rating) }
    it { should validate_numericality_of(:rating).only_integer }
    it { should validate_numericality_of(:rating).is_greater_than_or_equal_to(1) }
    it { should validate_numericality_of(:rating).is_less_than_or_equal_to(5) }
    it { should validate_length_of(:comment).is_at_most(1000) }
    it { should validate_length_of(:title).is_at_most(100) }

    context 'uniqueness validation' do
      let(:user) { create(:user) }
      let(:destination) { create(:destination) }
      
      before { create(:review, user: user, reviewable: destination) }

      it 'prevents duplicate reviews from same user on same reviewable' do
        duplicate_review = build(:review, user: user, reviewable: destination)
        expect(duplicate_review).not_to be_valid
        expect(duplicate_review.errors[:user_id]).to include('já avaliou este item')
      end

      it 'allows same user to review different reviewables' do
        other_destination = create(:destination)
        review = build(:review, user: user, reviewable: other_destination)
        expect(review).to be_valid
      end

      it 'allows different users to review same reviewable' do
        other_user = create(:user)
        review = build(:review, user: other_user, reviewable: destination)
        expect(review).to be_valid
      end
    end
  end

  describe 'scopes' do
    let!(:old_review) { create(:review, rating: 3).tap { |r| r.update_columns(created_at: 2.days.ago) } }
    let!(:new_review) { create(:review, rating: 5).tap { |r| r.update_columns(created_at: 1.day.ago) } }
    let!(:medium_review) { create(:review, rating: 4).tap { |r| r.update_columns(created_at: Time.current) } }

    describe '.recent' do
      it 'orders reviews by creation date descending' do
        expect(Review.recent.pluck(:id)).to eq([medium_review.id, new_review.id, old_review.id])
      end
    end

    describe '.by_rating' do
      it 'filters reviews by rating' do
        expect(Review.by_rating(5).pluck(:id)).to eq([new_review.id])
      end
    end

    describe '.highest_rated' do
      it 'orders reviews by rating descending' do
        expect(Review.highest_rated.first.id).to eq(new_review.id)
      end
    end
  end

  describe '.average_rating' do
    let(:destination) { create(:destination) }

    context 'with reviews' do
      before do
        create(:review, reviewable: destination, rating: 5)
        create(:review, reviewable: destination, rating: 3)
        create(:review, reviewable: destination, rating: 4)
      end

      it 'calculates the average rating' do
        expect(destination.reviews.average_rating).to eq(4.0)
      end
    end

    context 'without reviews' do
      it 'returns 0.0' do
        expect(destination.reviews.average_rating).to eq(0.0)
      end
    end
  end

  describe 'polymorphic associations' do
    it 'can be associated with a Destination' do
      destination = create(:destination)
      review = create(:review, reviewable: destination)
      expect(review.reviewable_type).to eq('Destination')
    end

    it 'can be associated with a Hotel' do
      hotel = create(:hotel)
      review = create(:review, reviewable: hotel)
      expect(review.reviewable_type).to eq('Hotel')
    end

    it 'can be associated with a Tour' do
      tour = create(:tour)
      review = create(:review, reviewable: tour)
      expect(review.reviewable_type).to eq('Tour')
    end
  end
end