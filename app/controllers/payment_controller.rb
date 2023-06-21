class PaymentController < ApplicationController
  include PaymongoService
  before_action :authenticate_user!
  before_action :redirect_unpaid_users, only: %i[new]
  before_action :redirect_paid_users, only: %i[create]
  # Saving the checkout session_id to the database flow
  # 1. When a checkout_session is created, save it into the database and attach it to the user with the status "ongoing".
  # 2. If a cancel happens, delete the session from the database by accessing the user's relationship.
  # 3. If they paid successfuly, we will update the status of the checkout session_id to "paid"

  def index; end

  def webhook
    puts request
    if request.headers['Paymongo-Signature']
      checkout_session_id = request['data']['id']
      @payment = Payment.find_by(checkout_session: checkout_session_id)
      @user = User.find(@payment.user_id)
      @user.update(paid: true)
      head :no_content
    end
    head :bad_request
  end

  def create
    paymongo_data = create_checkout_session

    # # Print the response body
    # puts response.body
    # Get the checkout_url from the data
    checkout_url = paymongo_data['data']['attributes']['checkout_url']

    # Get the session_id
    checkout_session_id = paymongo_data['data']['id']
    if current_user.payment.present?
      current_user.payment.update(checkout_session: checkout_session_id)
    else
      current_user.create_payment(checkout_session: checkout_session_id)
    end
    # Redirect to the checkout_url
    redirect_to checkout_url, allow_other_host: true
  end

  def cancel
    if current_user.payment.present?
      current_user.payment.destroy
    end
    redirect_to access_page_path
  end
end
