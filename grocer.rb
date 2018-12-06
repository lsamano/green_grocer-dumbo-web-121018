def consolidate_cart(cart)
  new_cart = {}
    cart.each do |veg_hash|
      veg_hash.each do |veg_name_key, price_clearance_hash|
        new_cart[veg_name_key] ||= price_clearance_hash
        if new_cart[veg_name_key][:count] == nil
          new_cart[veg_name_key][:count] = 1
        else
          new_cart[veg_name_key][:count] += 1
        end
      end
    end
  new_cart
end

def apply_coupons(cart, coupons)
  new_cart = {}
  new_cart.merge!(cart)
  coupons.each do |coupon_index|
    cart.each do |veg_name_key, price_clearance_hash|
      if veg_name_key == coupon_index[:item] && new_cart[veg_name_key][:count] >= coupon_index[:num]
        if new_cart["#{veg_name_key} W/COUPON"] == nil
          new_cart["#{veg_name_key} W/COUPON"] = {
            :price => coupon_index[:cost],
            :clearance => price_clearance_hash[:clearance],
            :count => 1
          }
        else
          new_cart["#{veg_name_key} W/COUPON"][:count] += 1
        end
          new_cart[veg_name_key][:count] -= coupon_index[:num]
      end
    end
  end
  new_cart
end

def apply_clearance(cart)
  new_cart = cart
  new_cart.each do |item_name, traits_hash|
    if traits_hash[:clearance]
      traits_hash[:price] = (0.8 * traits_hash[:price]).round(2)
    end
  end
  new_cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  ready_cart = apply_clearance(apply_coupons(consolidated_cart, coupons))
  cart_total = 0
  ready_cart.each do |item_name, traits_hash|
    cart_total += (traits_hash[:price] * traits_hash[:count])
  end
  if cart_total > 100
    cart_total = (cart_total * 0.9)
  end
  cart_total
end
