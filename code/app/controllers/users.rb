class Users < Application
  # provides :xml, :yaml, :js
  
  before :ensure_authenticated, :exclude => [:new, :create]
  
  def index
    @users = User.all
    display @users
  end

  def show(id = params[:id])
    @user = User.get(id)
    raise NotFound unless @user
    display @user
  end

  def new
    only_provides :html
    @user = User.new
    display @user
  end

  def edit(id = params[:id])
    only_provides :html
    @user = User.get(id)
    raise NotFound unless @user
    display @user
  end

  def create(user = params[:user])
    @user = User.new(user)
    if @user.save
      session[:user] = @user.id
      redirect resource(:products), :message => {:notice => "Signed up successfully!"}
    else
      message[:error] = "User failed to be created"
      render :new
    end
  end

  def update(id = params[:id], user = params[:user])
    @user = User.get(id)
    raise NotFound unless @user
    if @user.update_attributes(user)
       redirect resource(@user)
    else
      display @user, :edit
    end
  end

  def destroy(id = params[:id])
    @user = User.get(id)
    raise NotFound unless @user
    if @user.destroy
      redirect resource(:users)
    else
      raise InternalServerError
    end
  end

end # Users
