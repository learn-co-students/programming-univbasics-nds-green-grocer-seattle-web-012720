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
end

def consolidate_cart(cart)
  consolidated_cart = []
  i = 0
  while i < cart.length do
    new_cart_item = find_item_by_name_in_collection(cart[i][:item], consolidated_cart)
    
    if new_cart_item
      new_cart_item[:count] += 1
    else
      new_cart_item = {
        :item => cart[i][:item],
        :price => cart[i][:price],
        :clearance => cart[i][:clearance],
        :count => 1
      }
      consolidated_cart << new_cart_item
    end
    i += 1
  end
  consolidated_cart
end
def apply_coupons(cart, coupons)
  i = 0
  while i < coupons.length do
    cart_item = find_item_by_name_in_collection(coupons[i][:item], cart)
    couponed_item_name = "#{coupons[i][:item]} W/COUPON"
    cart_item_w_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
    
    if cart_item && cart_item[:count] >= coupons[i][:num]
      if cart_item_w_coupon
        cart_item_w_coupon[:count] += coupons[i][:num]
        cart_item[:count] -= coupons[i][:num]
      else
        cart_item_w_coupon = {
          :item => couponed_item_name,
          :price => coupons[i][:cost] / coupons[i][:num],
          :count => coupons[i][:num],
          :clearance => cart_item[:clearance]
        }
        cart << cart_item_w_coupon
        cart_item[:count] -= coupons[i][:num]
      end
    end
    i += 1
  end
  cart
  #coupons = [{:item=>"AVOCADO", :num=>2, :cost=>5.0}]
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  i = 0
  while i < cart.length do
    if cart[i][:clearance] == true
      cart[i][:price] = cart[i][:price] * 0.8
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
  consolidated_cart = consolidate_cart(cart)
  couponed = apply_coupons(consolidated_cart, coupons)
  consolidated_and_discounted = apply_clearance(couponed)
  i = 0
  total = 0
  while i < consolidated_and_discounted.length do
    total += consolidated_and_discounted[i][:price] * consolidated_and_discounted[i][:count]
    i += 1
  end
  if total >= 100 
    total = total * 0.9
  end  
  total.round(2)
end
