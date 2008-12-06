require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a product exists" do
  Product.all.destroy!
  request(resource(:products), :method => "POST", 
    :params => { :product => { :id => nil }})
end

describe "resource(:products)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:products))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of products" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a product exists" do
    before(:each) do
      @response = request(resource(:products))
    end
    
    it "has a list of products" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Product.all.destroy!
      @response = request(resource(:products), :method => "POST", 
        :params => { :product => { :id => nil }})
    end
    
    it "redirects to resource(:products)" do
      @response.should redirect_to(resource(Product.first), :message => {:notice => "product was successfully created"})
    end
    
  end
end

describe "resource(@product)" do 
  describe "a successful DELETE", :given => "a product exists" do
     before(:each) do
       @response = request(resource(Product.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:products))
     end

   end
end

describe "resource(:products, :new)" do
  before(:each) do
    @response = request(resource(:products, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@product, :edit)", :given => "a product exists" do
  before(:each) do
    @response = request(resource(Product.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@product)", :given => "a product exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Product.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @product = Product.first
      @response = request(resource(@product), :method => "PUT", 
        :params => { :product => {:id => @product.id} })
    end
  
    it "redirect to the article show action" do
      @response.should redirect_to(resource(@product))
    end
  end
  
end

