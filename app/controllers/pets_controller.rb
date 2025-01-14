class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do
    @owners = Owner.all 
    erb :'/pets/new'
  end

  post '/pets' do
    if !params[:owner][:name].empty?
      @owner = Owner.create(params[:owner])
      @pet = Pet.create(name: params[:pet][:name], owner_id: @owner.id)
    else
      @pet = Pet.create(params[:pet])
    end
    
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    @pet =  Pet.find(params[:id])
    
    if !params[:owner][:name].empty?
      @owner = Owner.create(params[:owner])
      @pet.update(name: params[:pet][:name], owner_id: @owner.id)
    else
      @pet.update(params[:pet])
    end

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'pets/edit'
  end
end