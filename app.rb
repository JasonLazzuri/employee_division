require('sinatra')
require('sinatra/reloader')
require("sinatra/activerecord")
require('./lib/division')
require('./lib/employee')
require('pry')
also_reload('lib/**/*.rb')
require('pg')

get('/') do
  @divisions = Division.all
  erb(:index)
end

post('/divisions') do
  Division.new({:name => params.fetch('division')}).save()
  erb(:success)
end

get('/divisions/:id') do
  @divisions = Division.all
  @division = Division.find(params.fetch('id').to_i())
  @employees = Employee.all
  erb(:division)
end

get('/divisions/:id/edit') do
  @division = Division.find(params.fetch('id').to_i())
  erb(:divisions_edit)
end

post('/divisions/:id') do
  @division = Division.find(params.fetch('id').to_i())
  @division.all()
  Employee.new({:name => params.fetch('employee')}).save()
  erb(:employee_success)
end

patch('/divisions/:id')do
  division = params.fetch('division')
  @division = Division.find(params.fetch('id').to_i())
  @division.update({:name => division})
  @division.save()
  @divisions = Division.all()
  erb(:success)
end
