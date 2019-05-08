class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = '3K1WK4D0HD2BYHIJNBCF1RUKNPZHLGGXSJZWZUZK2GAGNDUP'
        req.params['client_secret'] = 'FUBH4VHLUAIXLXADU10BSY4EE52MY43PCBL0JKVUHKD3HNVC'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
      end

      body = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body["response"]["venues"]
      else
        @error = body["meta"]["errorDetail"]
      end

    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again"
    end
    render 'search'
  end

end
