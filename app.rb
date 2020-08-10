#
# @ Javier Felipe Toribio 2020
#
# testing Sinatra framework
#

require 'json'
require 'sinatra'

class ToDo < Sinatra::Base

  DATABASE_FILE = "tareas.json"

  def initialize

    # do NOT forget call always Sinatra::Base initialize
    super()

    text = File.read(DATABASE_FILE)

    data = JSON.parse(text)

    @tasks = data['list']

  end

  get '/' do

    erb :index

  end

  post '/cast' do

    @message = "Gracias por enviar sus resultados"

    @ended = []

    @tasks.each do |task|

      key = task['id']

      if params[key]

        @ended << task['desc']

        task['ended'] = true

      end

    end

    save

    erb :cast

 end

private

  def save

    begin

      new_file = DATABASE_FILE + ".new"

      data = { "list" => @tasks }

      json = data.to_json

      file = File.open(new_file, "w")

      file.write(json)

      file.close

    rescue StandardError

      puts "Error when saving json data in #{new_file}"

    end

  end

end
