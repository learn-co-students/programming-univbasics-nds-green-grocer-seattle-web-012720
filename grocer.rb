def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # name is a string of item to find 
  #collection is array to search through
  #returns nil if no match is found
  #returns the matching hash if a match is found between name and hash's item key
  
  i = 0
  while i < collection.length do
    if name == collection[i][:item]
      return collection[i]
    else i += 1
    end
  end
  nil
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  
  i = 0 
  consolidated = []
  
  while i < cart.length do
    current = cart[i][:item]
    if find_item_by_name_in_collection(current, consolidated)
      find_item_by_name_in_collection(current, consolidated)[:count] += 1
    else new_item = cart[i]
      new_item[:count] = 1
      consolidated << new_item
    end
    i += 1
  end
  consolidated
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  #iterate through coupon list to find a match
  # at each match, add a discounted item
  # ensure minimum number of items for discount to apply

  i = 0
  while i < coupons.length do
    # hash of the cart item that matches the coupon
    current_item = find_item_by_name_in_collection(coupons[i][:item], cart)
    if current_item
      if current_item[:count] >= coupons[i][:num]
        discounted_item = {
          item: current_item[:item] + " W/COUPON",
          price: (coupons[i][:cost]/coupons[i][:num]).round(2),
          clearance: current_item[:clearance],
          count: coupons[i][:num]
        }
        current_item[:count] = current_item[:count] - coupons[i][:num]
        cart << discounted_item
      end
    end
    i += 1
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  i = 0
  while i < cart.length do
    if cart[i][:clearance] == true
      cart[i][:price] = (cart[i][:price] * 0.8).round(2)
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
  
  totaled_cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  i = 0
  total = 0
  while i < totaled_cart.length do
    total += (totaled_cart[i][:price] * totaled_cart[i][:count])
    i += 1
  end
  if total > 100 
    total = (0.9*total).round(2)
  end
  total
end
