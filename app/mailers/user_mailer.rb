class UserMailer < ApplicationMailer
	 default from: "deepankan.chitragupt786@gmail.com"

	def send_mail(random_number, first_name1, last_name1, email1, mobile_no1,first_name2 ,last_name2, params, user )

		@random_number = random_number
		@first_name1 = first_name1
		@first_name2 = first_name2
		@last_name1 = last_name1
		@last_name2 = last_name2
		@email1 = email1
		@mobile_no1 = mobile_no1
		@name = user.name
        mail(to: "#{user.email},#{@email1}", cc: 'deepankan.chitragupt@gmail.com', subject: "Boking Confirmation.Thanks!- for Booking with us")
	end


	
end