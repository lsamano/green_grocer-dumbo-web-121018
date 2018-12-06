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
  # code here
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
