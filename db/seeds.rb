Category.create!(name: "All products", parent_id: 0)

2.times do |n|
  category_names = ["Food", "Drink"]
  name = category_names[n]
  parent_id = 1
  Category.create!(name: name, parent_id: parent_id)
end

2.times do |n|
  category_names = ["Coffee", "Tea"]
  name = category_names[n]
  parent_id = 3
  Category.create!(name: name, parent_id: parent_id)
end

4.times do |n|
  product_names = ["Black Coffee", "Espresso", "Green Tea", "Black Tea"]
  category_ids = [4, 4, 5, 5]
  price_values = [30000, 40000, 50000, 60000]
  Product.create!(name: product_names[n],
    price: price_values[n],
    quantity: 10,
    category_id: category_ids[n])
end

User.create!(name: "Nguyen Chanh Huan", email: "admin@gmail.com", address: "DN",
  phone: "0123456789", password: "111111", password_confirmation: "111111", role: 1)

User.create!(name: "client", email: "client@gmail.com", address: "DN",
  phone: "0123456789", password: "111111", password_confirmation: "111111", role: 0)

User.create!(name: "Ky Phong", email: "phong@gmail.com", address: "DN",
  phone: "0123456789", password: "111111", password_confirmation: "111111", role: 0)

5.times do |n|
  name = "example user"
  email = "example#{n+1}@gmail.com"
  address = "DN"
  phone = "0123456789"
  password = "111111"
  User.create!(name: name, email: email, address: address, phone: phone, password: password,
    password_confirmation: password)
end

2.times do |n|
  users = [2, 3]
  status = [0, 3]
  Order.create!(
    user_id: users[n],
    status: status[n])
end

4.times do |n|
  OrderProduct.create!(
    product_id: n+1,
    price: Product.find(n+1).price,
    quantity: 2,
    order_id: 1)
  OrderProduct.create!(
    product_id: n+1,
    price: Product.find(n+1).price,
    quantity: 2,
    order_id: 2)
end
