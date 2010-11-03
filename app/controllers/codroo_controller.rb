class CodrooController < ApplicationController
  before_filter :require_user

  def new
    @codroo = Codroo.new
  end

  def create
    @codroo = Codroo.new(params[:codroo],
      :user_id => session[:id],
      :active => 1)
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
    @codroos = Codroo.limit(params[:limit]).offset(params[:offset])
    #@codroos = Codroo.all
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

