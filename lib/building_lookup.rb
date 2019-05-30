require "http"

class Building
  attr_accessor :id, :name, :address, :height, :construction_date, :architect, :image
 

  def initialize(input_options)
    # add attributes here as instance variables
   @id = input_options['id']
   @name = input_options['name']
   @address = input_options['address']
   @height = input_options['height']
   @construction_date = input_options['construction_date']
   @architect = input_options['architect']
   @image = input_options['image']

  end

  def self.find(input_id)
    # write your logic for the method here
    response = HTTP.get("http://localhost:3000/api/buildings/#{input_id}")
    Building.new(response.parse)
  end

  def self.all
    buildings = []
    response = HTTP.get("http://localhost:3000/api/buildings")
    response.parse.each do |building|
      buildings << Building.new(building)
    end 
    buildings
  end

  def self.create(building_params)
    response = HTTP.post(
                          "http://localhost:3000/api/buildings",
                          form: building_params
                          )
    Building.new(response.parse)
  end

  def update(building_params)
    response = HTTP.patch(
                          "http://localhost:3000/api/buildings/#{@id}",
                          form: building_params
                          )
    @id = response.parse['id']
    @name = response.parse['name']
    @address = response.parse['address']
    @height = response.parse['height']
    @construction_date = response.parse['construction_date']
    @architect = response.parse['architect']
    @image = response.parse['image']
  end

  def destroy
    response = HTTP.delete("http://localhost:3000/api/buildings/#{@id}")

  end
end
