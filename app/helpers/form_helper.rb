module FormHelper
  def setup_user(user)
    user.profile ||= Profile.new
    user
  end
  
  def setup_product(product)
  	product.category ||= Category.new
    product
  end
  def setup_seller(seller)
  	seller.user||= User.new
  	seller.user.profile||=Profile.new
  	seller
  end
end