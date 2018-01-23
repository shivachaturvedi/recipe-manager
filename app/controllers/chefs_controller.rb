class ChefsController < ApplicationController
  before_action :set_chef, only: [:edit, :update, :show, :follow]
  before_action :require_same_user, only: [:edit, :update]

  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 3)
  end
  
  def new
    @chef = Chef.new
  end
  
  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      flash[:success] = "Account has been created succesfully"
      if logged_in? and !current_user.admin?
        session[:chef_id] = @chef.id
      end
      redirect_to recipes_path
    else
      render 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    if @chef.update(chef_params)
      flash[:success] = "Profile has been updated succesfully"
      redirect_to chef_path(@chef)
    else
      render 'edit'
    end
  end
  
  def show
    @recipes = @chef.recipes.paginate(page: params[:page], per_page: 3)
    @following = Follower.where(follower_id: @chef.id)
  end
  
  def destroy
    Chef.find(params[:id]).destroy
    flash[:success] = "Chef Deleted"
    Recipe.destroy_all(chef_id: params[:id])
    Follower.destroy_all(follower_id[:id])
    redirect_to root_path
  end
  
  def follow
    follower = Follower.create(chef_id: params[:id], follower_id: current_user.id)
      if follower.valid?
        flash[:success] = "You are now following this chef"
        redirect_to :back
      else
        flash[:danger] = "Something went wrong!"
        redirect_to :back
      end
  end
  
  def unfollow
    Follower.where(chef_id: params[:id], follower_id: current_user.id).destroy_all()
      if Follower.exists?(chef_id:params[:id], follower_id: current_user.id)
        flash[:danger] = "Something went wrong"
        redirect_to :back
      else
        flash[:success] = "You have unfollowed this Chef"
        redirect_to :back
      end
  end
  
  private
  
    def chef_params
      params.require(:chef).permit(:chefname, :email, :password)  
    end
    
    def set_chef
      @chef = Chef.find(params[:id])
    end
    
    def require_same_user
      if current_user != @chef and !current_user.admin?
        flash[:danger] = "You can only edit your own profile"
        redirect_to root_path
      end
    end
end
