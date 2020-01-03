def find_item_by_name_in_collection(name, collection)
  i = 0 
  while i < collection.length do 
    if name == collection[i][:item]
       return collection[i]
    end
    i += 1 
  end 
end

def consolidate_cart(cart)
  new_cart = [] 
  i = 0 
 while i < cart.length do
   item = cart[i][:item]
   new_cart_item = find_item_by_name_in_collection(item, new_cart) 
   if new_cart_item != nil 
     new_cart_item[:count] += 1 
   else 
     new_cart_item = {
       :item => cart[i][:item], 
       :price =>cart[i][:price], 
       :clearance => cart[i][:clearance], 
       :count => 1}
     new_cart << new_cart_item
   end 
   i += 1 
 end 
  new_cart
end

def apply_coupons(cart, coupons)
  i = 0
  coupon_cart = [] 
  while i < coupons.length do 
    cart_item = find_item_by_name_in_collection(coupons[i][:item], cart)
    couponed_item_name = "#{coupons[i][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
    if cart_item && cart_item[:count] >= coupons[i][:num]
      if cart_item_with_coupon
        cart_item_with_coupon[:count] += coupons[i][:num]
        cart_item[:count] -= coupons[i][:num]
      else 
        cart_item_with_coupon = {
      :item => couponed_item_name, 
       :price => coupons[i][:cost] / coupons[i][:num] , 
       :clearance => cart_item[:clearance], 
       :count => coupons[i][:num]
        }
        cart << cart_item_with_coupon
        cart_item[:count] -= coupons[i][:num]
      end 
    end 
    i += 1 
  end 
  cart 
end

def apply_clearance(cart)
 i = 0 
 while i < cart.length do
   if cart[i][:clearance] 
     new_price = cart[i][:price] * 0.8
     cart[i][:price] = new_price.round(2)
   end 
   i += 1 
 end 
 cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  i = 0 
  total = 0 
    consolidated_cart = consolidate_cart(cart)
    couponed_cart = apply_coupons(consolidated_cart, coupons)
    clearanced_cart = apply_clearance(couponed_cart)
    while i < couponed_cart.length do 
      total += clearanced_cart[i][:price] * clearanced_cart[i][:count]
      i += 1 
    end 
     if total > 100
        total = total * 0.9
      end
      print total
      total 
end 