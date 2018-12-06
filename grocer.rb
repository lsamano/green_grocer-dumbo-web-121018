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
  #coupon_veg_name = coupons[0]
  coupons.each do |coupon_index|
    cart.each do |veg_name_key, price_clearance_hash|
      if veg_name_key == coupon_index[:item] && new_cart["#{veg_name_key} W/COUPON"] == nil
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
  new_cart
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
