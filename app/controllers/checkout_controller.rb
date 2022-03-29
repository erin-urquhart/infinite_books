class CheckoutController < ApplicationController
  def list_items
    cart_items = []
    quantity = []
    total = 0
    session[:shopping_cart].each do |b|
      quantity << b['quantity']
    end
    province = Province.find(current_user.province_id)
    taxes = (1 + province[:hst] + province[:gst] + province[:pst])
    counter = 0
    cart.each do |item|
      total += ((item.price_cents)).to_i * quantity[counter]
      cart_items << {"name" => item.name, "description" => item.author,
      "amount" => ((item.price_cents)).to_i,
      "currency" => "cad", "quantity" => quantity[counter] }
      counter += 1
    end
    cart_items << {"name" => "HST", "amount" => (total * province[:hst]).to_i, "currency" => "cad", "quantity" => 1}
    cart_items << {"name" => "GST", "amount" => (total * province[:gst]).to_i, "currency" => "cad", "quantity" => 1}
    cart_items << {"name" => "PST", "amount" => (total * province[:pst]).to_i, "currency" => "cad", "quantity" => 1}
    puts cart_items
    return cart_items
  end

  def create
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: checkout_cancel_url,
      line_items: list_items

    )
    redirect_to @session.url, allow_other_host: true
    # respond_to do |format|
    #   format.js
    # end
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    province = Province.find(current_user.province_id)
    taxes = (province[:hst] + province[:gst] + province[:pst])
    subt = (@payment_intent.amount_received.to_d / 100 * taxes)
    subtotal = (@payment_intent.amount_received.to_d / 100 - subt).round(2)
    order_status = if @session.payment_intent
                      "paid"
                    else
                     "unpaid"
                    end
    new_order = current_user.orders.create(
      total:      @payment_intent.amount_received.to_d / 100,
      subtotal: subtotal,
      taxes:      taxes,
      payment_id: @session.payment_intent,
      status:     order_status
    )
    redirect_to root_path
  end

  def cancel

  end
end
