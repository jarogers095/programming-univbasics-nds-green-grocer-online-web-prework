require 'pp'

def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  
  collection.each do |item|
    if (item[:item] == name)
      return item
    end
  end
  
  return nil
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  
  consolidated_cart = []
  
  cart.each do |n|
    item_if_it_exists = find_item_by_name_in_collection(n[:item], consolidated_cart)
    
    if item_if_it_exists != nil
      item_if_it_exists[:count] += 1
    else
      consolidated_cart.push(n)
      consolidated_cart.last[:count] = 1
    end
  end
    
  return consolidated_cart
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  coupons.each do |coupon|
    item_in_cart = find_item_by_name_in_collection(coupon[:item], cart)
    if (item_in_cart != nil)
      if (item_in_cart[:count] >= coupon[:num])
        item_in_cart[:count] -= coupon[:num]
        cart.push(
          {
            item: "#{coupon[:item]} W/COUPON",
            price: (coupon[:cost] / coupon[:num]),
            clearance: item_in_cart[:clearance],
            count: coupon[:num]
          }
        )
      #Alternative alters original item instead of adding a new entry
      #if number of items in cart is equal to the number of items 
      #required by the coupon
      '''elsif (item_in_cart[:count] == coupon[:num])
          item_in_cart[:item] = "#{coupon[:item]} W/COUPON"
          item_in_cart[:price] = (coupon[:cost] / coupon[:num])'''
      end
    end
  end 
  
  return cart 
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  cart.each do |item|
    if (item[:clearance] == true)
      item[:price] = (item[:price] * 0.8).round(2)
    end
  end
  
  return cart
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
  
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  
  total = 0
  cart.each do |item|
    total += (item[:price] * item[:count])
  end
  
  if (total > 100)
    total *= 0.9
  end
  
  return total
end
