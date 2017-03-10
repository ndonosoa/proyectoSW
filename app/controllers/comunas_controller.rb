class ComunasController < ApplicationController
  def index
    @regiones = Region.where(state_region: 1)
end


 def getcomunas
    sql = "select c.id, c.nombre_comuna, r.name_region, c.state_comuna
        from  comunas c 
        inner join regions r on (r.id = c.region_id)
        where c.state_comuna = 1 order by c.nombre_comuna asc "

   list = ActiveRecord::Base.connection.execute(sql)      
    render json: {
      comuna: list
    }.to_json	
end

def softdelete
  @comuna = Comuna.find(params[:id])
  @comuna.state_comuna = 0
  if @comuna.save
  else
    render :json => { :errors => @a.errors }, :status => 422
  end
end

def edit
  comuna = Comuna.find(params[:id])
	render json: {
		comuna: comuna
	}.to_json
end

def update
  a = Comuna.find(params[:id])
  if a.update(comuna_params)
  else
    render :json => { :errors => @a.errors }, :status => 422
  end
  
end


def create
  @reactivar = Comuna.find_by(nombre_comuna: params[:comuna][:nombre_comuna])
  if @reactivar && @reactivar.state_comuna == 0
    @reactivar.state_comuna = 1
    if @reactivar.save
    else
      render :json => { :errors => @reactivar.errors }, :status => 422
    end
  else
    @asd = Comuna.new(nombre_comuna: params[:comuna][:nombre_comuna],
      state_comuna: 1, region_id: params[:comuna][:region_id])
    if @asd.save
    else
      render :json => { :errors => @asd.errors }, :status => 422
    end
  end
end


   def comuna_params
     params.require(:comuna).permit(:nombre_comuna, :region_id)
   end

end
