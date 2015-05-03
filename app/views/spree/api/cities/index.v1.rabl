object false

child(@cities => :cities) do
  attributes *city_attributes
end

if @cities.respond_to?(:num_pages)
  node(:count) { @cities.count }
  node(:current_page) { params[:page] || 1 }
  node(:pages) { @cities.num_pages }
end
