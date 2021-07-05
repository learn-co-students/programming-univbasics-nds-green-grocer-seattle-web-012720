def find_item_by_name_in_collection(name, collection)
  index = 0
  while index < collection.count do
    if collection[index][:item] == name
      return collection[index]
    end
    index += 1
  end
  return nil
end

# adds :count to the item hash
def item_with_count(item_info)
  {
    item: item_info[:item],
    price: item_info[:price],
    clearance: item_info[:clearance],
    count: 0
  }
end

def consolidate_cart(cart)
  
  new_cart = []
  
  counter = 0
  while counter < cart.count
    new_cart_item = find_item_by_name_in_collection(cart[counter][:item], new_cart)
    
    if new_cart_item != nil
      new_cart_item[:count] += 1
    else
      new_cart_item = {
        item: cart[counter][:item],
        price: cart[counter][:price],
        clearance: cart[counter][:clearance],
        count: 1
      }
      new_cart << new_cart_item
    end
    counter += 1
  end
  new_cart
end

def apply_coupons(cart, coupons)
  index = 0
  while index < coupons.count
    cart_item = find_item_by_name_in_collection(coupons[index][:item], cart)
    couponed_item_name = "#{coupons[index][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
    if cart_item && cart_item[:count] >= coupons[index][:num]
      if cart_item_with_coupon
        cart_item_with_coupon[:count] += coupons[index][:num]
        cart_item[:count] -= coupons[index][:num]
      else
        cart_item_with_coupon = {
          item: couponed_item_name,
          price: coupons[index][:cost] / coupons[index][:num],
          count: coupons[index][:num],
          clearance: cart_item[:clearance]
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
  index = 0
  while index < cart.count
    if cart[index][:clearance]
      cart[index][:price] *= 0.8
    end
    index += 1
  end
  cart
end

def checkout(cart, coupons)
  
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  discounted_cart = apply_clearance(couponed_cart)
  
  grand_total = 0
  counter = 0
  while counter < discounted_cart.length
    grand_total += discounted_cart[counter][:price] * discounted_cart[counter][:count]
    counter += 1
  end
  if grand_total > 100
    grand_total *= 0.90
  end
  grand_total.round(2)
end
