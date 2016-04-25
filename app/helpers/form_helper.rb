module FormHelper
  def setup_user(user)
    user.profile ||= Profile.new
    user
  end
  
  def 	setup_product(product)
  	product.category ||= Category.new
    product
  end
end