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
  @category = Category.update(category_params)
  
end


def create
    @category = Category.new(category_params)
    @category.save

  end


   def category_params
     params.require(:category).permit(:name_category)
   end

end

