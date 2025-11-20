# spec/routing/reviews_routing_spec.rb
require 'rails_helper'

RSpec.describe ReviewsController, type: :routing do
  describe 'routing for destinations' do
    it 'routes to #index' do
      expect(get: '/destinations/1/reviews').to route_to('reviews#index', destination_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/destinations/1/reviews/1').to route_to('reviews#show', destination_id: '1', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/destinations/1/reviews').to route_to('reviews#create', destination_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/destinations/1/reviews/1').to route_to('reviews#update', destination_id: '1', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/destinations/1/reviews/1').to route_to('reviews#update', destination_id: '1', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/destinations/1/reviews/1').to route_to('reviews#destroy', destination_id: '1', id: '1')
    end
  end

  describe 'routing for hotels' do
    it 'routes to #index' do
      expect(get: '/hotels/1/reviews').to route_to('reviews#index', hotel_id: '1')
    end

    it 'routes to #create' do
      expect(post: '/hotels/1/reviews').to route_to('reviews#create', hotel_id: '1')
    end
  end

  describe 'routing for tours' do
    it 'routes to #index' do
      expect(get: '/tours/1/reviews').to route_to('reviews#index', tour_id: '1')
    end

    it 'routes to #create' do
      expect(post: '/tours/1/reviews').to route_to('reviews#create', tour_id: '1')
    end
  end
end