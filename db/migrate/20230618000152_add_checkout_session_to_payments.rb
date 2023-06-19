class AddCheckoutSessionToPayments < ActiveRecord::Migration[7.0]
  def change
    add_column :payments, :checkout_session, :string
  end
end
