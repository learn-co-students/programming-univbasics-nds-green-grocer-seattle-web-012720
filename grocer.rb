def find_item_by_name_in_collection(name, collection)
  index = 0 
  while index < collection.length do 
    if collection[index][:item] == name
      return collection[index]
    end 
      index += 1 
  end 
end

def consolidate_cart(cart)
  array = []
  index = 0 
  while index < cart.length do 
    items_in_cart = find_item_by_name_in_collection(cart[index][:item], array)
    if items_in_cart
      items_in_cart[:count] += 1 
    else
      items_in_cart = {
      :item => cart[index][:item],
      :price => cart[index][:price],
      :clearance => cart[index][:clearance],
      :count => 1,
      }
      array << items_in_cart
    end 
  index += 1 
  end
  array 
end

def apply_coupons(cart, coupons)
  
  #iterating through the coupons structure
  index = 0 
  while index < coupons.length
  
  #finding if our coupon item is in the cart. if it does exist in the cart this returns truth, if not returns nil/falsey.
  cart_item = find_item_by_name_in_collection(coupons[index][:item], cart)
  
  #checking to see if the coupon item exists in the original cart.
  couponed_item_name = "#{coupons[index][:item]} W/COUPON"
  
  #check if item with the coupon already exists.
  cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
  if cart_item && cart_item[:count] >= coupons[index][:num]
    if cart_item_with_coupon 
      cart_item_with_coupon[:count] += coupons[index][:num]
      cart_item[:count] -= coupons[index][:num]
    else 
    cart_item_with_coupon ={
      :item => couponed_item_name,
      :price => coupons[index][:cost] / coupons[index][:num],
      :clearance => cart_item[:clearance],
      :count => coupons[index][:num]
    }  
    cart << cart_item_with_coupon
    cart_item[:count] -= coupons[index][:num]
    end 
  end 
  index += 1 
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  index = 0 
  while index < cart.length do
    if cart[index][:clearance]
      cart[index][:price] = cart[index][:price] * 0.8
    end 
    index += 1 
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
  new_cart = consolidate_cart(cart)
  apply_coupons(new_cart, coupons)
  apply_clearance(new_cart)
  index = 0 
  total = 0 
  while index < new_cart.length
    total += new_cart[index][:price] * new_cart[index][:count]
    index += 1
  end
  if total >= 100
    total = total * 0.9
  end 
  total.round(2)
end