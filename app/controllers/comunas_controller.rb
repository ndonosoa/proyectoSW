class ComunasController < ApplicationController
  def index
    @regiones = Region.all
end


 def getcomunas
    sql = "select c.id, c.nombre_comuna, r.name_region
        from  comunas c 
        inner join regions r on (r.id = c.region_id)
        order by c.nombre_comuna asc"

   list = ActiveRecord::Base.connection.execute(sql)      
    render json: {
      comuna: list
    }.to_json	
end

def destroy
  @comuna = Comuna.find(params[:id])
  @comuna.destroy
end

def edit
  comuna = Comuna.find(params[:id])
	render json: {
		comuna: comuna
	}.to_json
end

def update
  a = Comuna.find(params[:id])
  a.update(comuna_params)
  
end


def create
    @comuna = Comuna.new(comuna_params)
   if @comuna.save
   else
      render :json => { :errors => @comuna.errors }, :status => 422
    end
  end


   def comuna_params
     params.require(:comuna).permit(:nombre_comuna, :region_id)
   end

end
