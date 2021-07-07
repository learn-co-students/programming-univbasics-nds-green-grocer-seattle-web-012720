require 'pry'

def find_item_by_name_in_collection(name, collection)
  i = 0
  while i < collection.length do
    if collection[i][:item] == name
      return collection[i]
    else
      i += 1
    end
  end
  
  # Implement me first!
  #
  # Consult README for inputs and outputs
end

def consolidate_cart(cart)
  current_cart = []
  i = 0

  while i < cart.length do

    item_in_hand = find_item_by_name_in_collection(cart[i][:item], current_cart)
    if item_in_hand != nil
      cart[i][:count] += 1
    else
      cart[i][:count] = 1
      current_cart << cart[i]
    end
    i += 1
  end
  current_cart
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
end

def apply_coupons(cart, coupons)
  applied_discounts = []
  i = 0
  
  while i < coupons.length
  discounted_item_name = "#{coupons[i][:item]} W/COUPON"
  discounted_item = find_item_by_name_in_collection(coupons[i][:item], cart)
  applied_coupon_item = find_item_by_name_in_collection(discounted_item_name, cart)
  #binding.pry
  if discounted_item && discounted_item[:count] >= coupons[i][:num]
    if applied_coupon_item
      applied_coupon_item[:count] += coupons[i][:num]
      discounted_item[:count] -= coupons[i][:num]
    else
      applied_coupon_item = {
        :item => discounted_item_name,
        :price => coupons[i][:cost] / coupons[i][:num],
        :count => coupons[i][:num],
        :clearance => discounted_item[:clearance]
      }
      cart << applied_coupon_item
      discounted_item[:count] -= coupons[i][:num]
      #binding.pry
    end
  end
  i += 1
end
  cart
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end

def apply_clearance(cart)
  i = 0
  while i < cart.length do
    if cart[i][:clearance]
      cart[i][:price] = (cart[i][:price] - (cart[i][:price] * 0.2)).round(2)
  
    end
    i += 1
  end
  cart
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)
  i = 0
  total = 0
  
  while i < final_cart.length do
    total += final_cart[i][:price] * final_cart[i][:count]
    i += 1
  end
  if total > 100
    total -= (total * 0.1).round(2)
  end
    total
  
  
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
end
