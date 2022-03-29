class CheckoutController < ApplicationController
  def list_items
    cart_items = []
    province = Province.find(current_user.province_id)
    taxes = (1 + province[:hst] + province[:gst] + province[:pst])
    cart.each do |item|
      cart_items << {"name" => item.name, "description" => item.description,
      "amount" => ((item.price * 100) * taxes).to_i,
      "currency" => "cad", adjustable_quantity: { enabled: true, minimum: 1,
        maximum: 10 }, quantity: 1 }
    end
    return cart_items
  end

  def create
    product = Book.find(params[:book_id])

    if product.nil?
      redirect_to books_path
      return
    end

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: checkout_cancel_url,
      line_items: [
        {
          name:book.name,
          description: book.description,
          amount: book.price_cents,
          currency: "cad",
          quantity: 1
        },
        {
          name:"GST",
          description: "Goods and Service Tax",
          amount: (book.price_cents * 0.05).to_i,
          currency: "cad",
          quantity: 1
        }
      ]

    )

    respond_to do |format|
      format.js
    end
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  end

  def cancel

  end
end
