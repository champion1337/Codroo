class CodroosController < ApplicationController
  #actions that require user login
  before_filter :require_user, :only => [:new, :create, :edit, :update, :destroy]
  #actions that require the user to be the owner
  before_filter :check_codroo_owner, :only => [:destroy,:edit,:update]

  #New Codroo
  def new
    @codroo = Codroo.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @codroo }
    end
  end

  #Create the new codroo
  def create
    @codroo = Codroo.new(params[:codroo])
    @codroo.active = 1
    @codroo.user_id = current_user.id
    if @codroo.save
      redirect_to(@codroo, :notice => "Successfully created")
    else
      render :action => "new"
    end
  end

  #delete a codroo. ownership checked in application controller
  def destroy
    @codroo = Codroo.find(params[:id])
    @codroo.destroy
    redirect_to(codroos_url)
  end
  #edit a codroo - this might be useless as the object is also instantiated 
  #when requesting the update action
  #TODO search edit/update difference
  def edit
    @codroo = Codroo.find(params[:id])
  end

  #update a codroo or render the edit page
  def update
    @codroo = Codroo.find(params[:id])

    if @codroo.update_attributes(params[:codroo])
      redirect_to(@codroo,:notice => "Information successfully updated")
    else
      render :action => "edit"
    end
  end


  #show all codroos
  def index
    @codroos = Codroo.all
    #@codroos = Codroo.all
  end

  #show only the codroos associated with the loggd in user
  def your_codroos
    @user = User.new
    @codroo = Codroo.new
    @user = User.find(current_user.id)
    @codroos = @user.codroos
  end

  #show information about a codroo
  def show
    @codroo = Codroo.find(params[:id])
  end

end

