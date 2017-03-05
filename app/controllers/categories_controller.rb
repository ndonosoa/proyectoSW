class CategoriesController < ApplicationController
#before_action :set_category, only: [:destroy, :edit]

def index
end


 def getcategories
    list = Category.all       
    render json: {
      category: list
    }.to_json	
end

def destroy
  @category = Category.find(params[:id])
  @category.destroy
end

def edit
  category = Category.find(params[:id])
	render json: {
		category: category
	}.to_json
end

def update
  @category = Category.find(params[:id])
  if @category.update(category_params)
  else
    render :json => { :errors => @category.errors }, :status => 422
  end
end


def create
    @category = Category.new(category_params)
    if @category.save
    else
    render :json => { :errors => @category.errors }, :status => 422
  end
end


   def category_params
     params.require(:category).permit(:name_category)
   end

end

