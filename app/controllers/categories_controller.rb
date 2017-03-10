class CategoriesController < ApplicationController
#before_action :set_category, only: [:destroy, :edit]

def index
end


 def getcategories
    list = Category.where(state_category: 1)       
    render json: {
      category: list
    }.to_json	
end

def softdelete
  @category = Category.find(params[:id])
  @category.state_category = 0
  if @category.save
  else
    render :json => { :errors => @category.errors }, :status => 422
  end

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
    @reactivar = Category.find_by(name_category: params[:category][:name_category])
    if @reactivar && @reactivar.state_category == 0
      @reactivar.state_category = 1
      if @reactivar.save
      else
        render :json => { :errors => @reactivar.errors }, :status => 422
      end
    else
      @asd = Category.new(name_category: params[:category][:name_category],
                state_category: 1)
      if @asd.save
      else
        render :json => { :errors => @asd.errors }, :status => 422
      end
    end
end


   def category_params
     params.require(:category).permit(:name_category)
   end

end

