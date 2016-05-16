class StaticPagesController < ApplicationController

      def index
      	@client_ip = remote_ip()
        #result = RestClient.get "http://api.worldweatheronline.com/premium/v1/weather.ashx?key=#{API_WEATHER}&q=#{@client_ip}&format=json&num_of_days=#{NO_OF_DAY_WEATHER}&includelocation=yes&tp=24" 
        # @result = JSON.parse(result)   
        # @result = @result['data']

      end 

	  def get_hotel_list
	  	   @check_in_date = params['dep_date']
		   @check_out_date = params['return_date']
		   @country = params[:city]
		   params['dep_date']  = params['dep_date'].gsub("-","")
		   params['return_date'] =  params['return_date'].gsub("-","")
		   #city_id = City.find_by_city_name(params[:city]).city_id
		    city_id = City.where("city_name ILIKE ?", "%#{params[:city]}%").first.city_id
		  get_name_result = RestClient.get "http://developer.goibibo.com/api/voyager/get_hotels_by_cityid/?app_id=#{API_APP_ID_GOIBIBO}&app_key=#{API_APP_KEY_GOIBIBO}&city_id=#{city_id}"
		  @hotel_name = JSON.parse(get_name_result)   
		  
		  result = RestClient.get "http://developer.goibibo.com/api/cyclone/?app_id=#{API_APP_ID_GOIBIBO}&app_key=#{API_APP_KEY_GOIBIBO}&city_id=#{city_id}&check_in=#{params['dep_date']}&check_out=#{params['return_date']}"
		  @result = JSON.parse(result)   
		  @key_hotel = {}
		  @hotel_name['data'].each do |k,v|

		     @key_hotel[k] = {'name' => v['hotel_geo_node']['name'], 'rating' => v['hotel_data_node']['rating'],'facilities' => (v['hotel_data_node']['facilities']['mapped'] if v['hotel_data_node']['facilities']),'city' => v['hotel_data_node']['loc']['city'], 'country' => v['hotel_data_node']['loc']['country'], 'state'=> v['hotel_data_node']['loc']['state'],'location' => v['hotel_data_node']['loc']['location'],'img' => (v['hotel_data_node']['img_selected']['thumb']['l'] if v['hotel_data_node']['img_selected']),'total_review' => (v['hotel_data_node']['extra']['gir_data_extended']['reviews'].count if v['hotel_data_node']['extra']['gir_data_extended']) }
		  end  

		  @result['data'].each do |k,v|
		    @key_hotel[k]['price'] = v['mp']
		  end  if @result
        @count = @key_hotel.count

    end 

   def go_search_flights
   	 @check_in_date = params['dep_date1']
	 @check_out_date = params['return_date1']
	 @from = params['origin']
	 @to = params['destination']
	 @class = params['seatingclass']
	 @adult = params['adults']
	 @children = params['children']
	 @infant = params['infants']
   	params['dep_date1']  = params['dep_date1'].gsub("-","")
   	params['return_date1'] =  params['return_date1'].gsub("-","") if params['return_date1']
   	params['children'] = params['children'].present? ? params['children'] : 0
   	params['infants'] = params['infants'].present? ? params['infants'] : 0
    params['adults'] =  params['adults'].present? ? params['adults'] : 1 

	  if params['return_date1'].present?
	  	result = RestClient.get "http://developer.goibibo.com/api/search/?app_id=#{API_APP_ID_GOIBIBO}&app_key=#{API_APP_KEY_GOIBIBO}&format=json&source=#{params['origin']}&destination=#{params['destination']}&dateofdeparture=#{params['dep_date1']}&dateofarrival=#{params['return_date1']}&seatingclass=#{params['seatingclass']}&adults=#{params['adults']}&children=#{params['children']}&infants=#{params['infants']}"	    
	    @flag = true
	  else
	    result = RestClient.get "http://developer.goibibo.com/api/search/?app_id=#{API_APP_ID_GOIBIBO}&app_key=#{API_APP_KEY_GOIBIBO}&format=json&source=#{params['origin']}&destination=#{params['destination']}&dateofdeparture=#{params['dep_date1']}&seatingclass=#{params['seatingclass']}&adults=#{params['adults']}&children=#{params['children']}&infants=#{params['infants']}"
	    @flag = false
	  end
	  @result = JSON.parse(result)
	  @count = @result['data']['onwardflights'].count + @result['data']['returnflights'].count
 
 end 

def get_list_bus

     @check_in_date = params['dep_date2']
	 @check_out_date = params['return_date2']
	 @from = params['bus_origin']
	 @to = params['bus_destination']
	
    params['dep_date2']  = params['dep_date2'].gsub("-","")
   	params['return_date2'] =  params['return_date2'].gsub("-","") if params['return_date2']
      
    if params['return_date2'].present?
    
    result = RestClient.get "http://developer.goibibo.com/api/bus/search/?app_id=#{API_APP_ID_GOIBIBO}&app_key=#{API_APP_KEY_GOIBIBO}&format=json&source=#{params['bus_origin']}&destination=#{params['bus_destination']}&dateofdeparture=#{params['dep_date2']}&dateofarrival=#{params['return_date2']}"
    @flag = true
   else
    result = RestClient.get "http://developer.goibibo.com/api/bus/search/?app_id=#{API_APP_ID_GOIBIBO}&app_key=#{API_APP_KEY_GOIBIBO}&format=json&source=#{params['bus_origin']}&destination=#{params['bus_destination']}&dateofdeparture=#{params['dep_date2']}"
    @flag = false
   end
   @result = JSON.parse(result)  
   @count = @result['data']['onwardflights'].count + @result['data']['returnflights'].count if @result['data']

end

end
