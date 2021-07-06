def find_item_by_name_in_collection(name, collection)
  index = 0 
  while index < collection.size 
    if collection[index][:item] == name
      return collection[index]
    end
    index += 1
  end
  return nil
end

def consolidate_cart(cart)
  new_Cart = []
  index = 0 
  while index < cart.size 
    item = find_item_by_name_in_collection(cart[index][:item],new_Cart)
    if item != nil
      item[:count] += 1 
    else 
      item = {
        :item => cart[index][:item],
        :price => cart[index][:price],
        :clearance => cart[index][:clearance],
        :count => 1
        }
        new_Cart << item
    end
    index += 1 
  end
  new_Cart
end

def apply_coupons(cart, coupons)
  index = 0 
  while index < coupons.size 
    coupon = coupons[index]
    item = find_item_by_name_in_collection(coupon[:item], cart)
    if item != nil
      new_count = (item[:count]/coupon[:num])*coupon[:num]
      item[:count] %= coupon[:num]
      new_name = "#{item[:item]} W/COUPON"
      cart << {
        :item => new_name,
        :price => coupon[:cost]/coupon[:num],
        :clearance => item[:clearance],
        :count => new_count
      }
    end 
    index += 1
  end 
  cart
end

def apply_clearance(cart)
  index = 0 
  while index < cart.size 
    if cart[index][:clearance] == true
      cart[index][:price] = (cart[index][:price]*0.8).round(1)
    end
    index += 1 
  end
  cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  apply_coupons_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(apply_coupons_cart)
  counter = 0
  grand_total = 0
  while counter < final_cart.size 
    grand_total += final_cart[counter][:price]*final_cart[counter][:count]
    counter += 1
  end
  if grand_total > 100
    grand_total *= 0.9
  end
  grand_total
end
