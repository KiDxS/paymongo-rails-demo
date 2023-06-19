class PaymentController < ApplicationController
  before_action :authenticate_user!
  before_action :user_paid_yet?, only: [:new, :create]
  # Saving the checkout session_id to the database flow
  # 1. When a checkout_session is created, save it into the database and attach it to the user with the status "ongoing".
  # 2. If a cancel happens, delete the session from the database by accessing the user's relationship.
  # 3. If they paid successfuly, we will update the status of the checkout session_id to "paid"

  def index; end

  def create
    # Set the API endpoint
    endpoint = 'https://api.paymongo.com/v1/checkout_sessions'
    api_key = ENV["PAYMONGO_SK_API_KEY"]

    # Set the request headers
    headers = {
      'accept' => 'application/json',
      'Content-Type' => 'application/json',
      'authorization' => "Basic #{api_key}"
    }
    # Set the request body
    body = {
      data: {
        attributes: {
          line_items: [
            {
              currency: 'PHP',
              amount: 10000,
              description: 'Access to the website',
              quantity: 1,
              name: 'Access'
            }
          ],
          payment_method_types: ['gcash'],
          send_email_receipt: false,
          show_description: true,
          show_line_items: true,
          cancel_url: 'http://localhost:3000/payment/cancel',
          description: 'Buy access to the website',
          success_url: 'http://localhost:3000/payment/success'
        }
      }
    }

    # Make the request
    response = HTTParty.post(endpoint, headers: headers, body: body.to_json)

    # Print the response body
    puts response.body
    # Get the checkout_url from the response
    checkout_url = response['data']['attributes']['checkout_url']

    # Get the session_id
    checkout_session_id = response['data']['id']
    if current_user.payment.present?
      current_user.payment.update(checkout_session: checkout_session_id)
    else
      current_user.create_payment(checkout_session: checkout_session_id)
    end
 
    # Redirect to the checkout_url
    redirect_to checkout_url, allow_other_host: true
  end

  def success
    current_user.update(paid: true)
    redirect_to root_path
  end

  def cancel
    if current_user.payment.present?
      current_user.payment.destroy
    end
    redirect_to  access_page_path
  end
  
end
