module PaymongoService
  def create_checkout_session
    endpoint = 'https://api.paymongo.com/v1/checkout_sessions'
    api_key = ENV['PAYMONGO_SK_API_KEY']

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
              amount: 10_000,
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
  end
end