class CheckoutController < ApplicationController
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
