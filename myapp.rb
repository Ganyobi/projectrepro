require 'rubygems'
require 'sinatra'
require 'mongoid'

Mongoid.load!('mongoid.yml')

class Project
	include Mongoid::Document

	field :title, type: String
	field :file_url, type: String
	field :author, type: String
	field :email, type: String
	field :course, type: String
end

get '/newpost' do
	erb :newpost
end 

post '/' do
	project = Project.new

	project.title = params[:title]
	project.author = params[:author]
	project.email = params[:email]
	project.course = params[:course]

	File.open('uploads/'+ params['file'][:filename], 'w') do |f|
		@url = f.write(params[:file][:temp].read)
	end

	project.save

	@projects = Project.all

	erb :index
end

get '/' do

	@projects = Project.all

	erb :index
end