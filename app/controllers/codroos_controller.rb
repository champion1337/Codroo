class CodroosController < ApplicationController
  before_filter :require_user, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :check_codroo_owner, :only => [:destroy,:edit,:update]
  def new
    @codroo = Codroo.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @codroo }
    end
  end

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

  def destroy
    @codroo = Codroo.find(params[:id])
    @codroo.destroy
    redirect_to(codroos_url)
  end

  def index
    @codroos = Codroo.all
    #@codroos = Codroo.all
  end

  def your_codroos
    @user = User.new
    @codroo = Codroo.new
    @user = User.find(current_user.id)
    @codroos = @user.codroos
  end

  def edit
    @codroo = Codroo.find(params[:id])
  end

  def update
    @codroo = Codroo.find(params[:id])

    if @codroo.update_attributes(params[:codroo])
      redirect_to(@codroo,:notice => "Information successfully updated")
    else
      render :action => "edit"
    end
  end

  def show
    @codroo = Codroo.find(params[:id])
  end

end

