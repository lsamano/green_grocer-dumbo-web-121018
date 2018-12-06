def consolidate_cart(cart)
  new_cart = {}
    cart.each do |item_hash|
      item_hash.each do |item_name, price_clearance_hash|
        new_cart[item_name] ||= price_clearance_hash #creates only 1 instance of each item
        if new_cart[item_name][:count] == nil
          new_cart[item_name][:count] = 1
        else
          new_cart[item_name][:count] += 1 # +1 on the :count if it already exists
        end
      end
    end
  new_cart
end

def apply_coupons(cart, coupons)
  new_cart = {}
  new_cart.merge!(cart)
  coupons.each do |coupon_index|
    cart.each do |item_name, price_clearance_hash|
      # Checks if the item is present in the cart & cart has enough to be discounted
      if item_name == coupon_index[:item] && new_cart[item_name][:count] >= coupon_index[:num]
        if new_cart["#{item_name} W/COUPON"] == nil
          # Creates one instance of the discounted item
          new_cart["#{item_name} W/COUPON"] = {
            :price => coupon_index[:cost],
            :clearance => price_clearance_hash[:clearance],
            :count => 1
          }
        else
          new_cart["#{item_name} W/COUPON"][:count] += 1 # +1 on :count if it already exists
        end
          # Decreases :count for the non-discounted version of the item
          new_cart[item_name][:count] -= coupon_index[:num]
      end
    end
  end
  new_cart
end

def apply_clearance(cart)
  new_cart = cart
  new_cart.each do |item_name, price_clearance_hash|
    if price_clearance_hash[:clearance] # Checks if item is on clearance
      price_clearance_hash[:price] = (0.8 * price_clearance_hash[:price]).round(2)
    end
  end
  new_cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  # All discounts are applied to prep the cart
  ready_cart = apply_clearance(apply_coupons(consolidated_cart, coupons))
  cart_total = 0
  ready_cart.each do |item_name, price_clearance_hash|
    # Calculates cost, price * count
    cart_total += (price_clearance_hash[:price] * price_clearance_hash[:count])
  end
  if cart_total > 100 # Applies 10% discount if over $100
    cart_total = (cart_total * 0.9)
  end
  cart_total
end
