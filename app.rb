#
# @ Javier Felipe Toribio 2020
#
# testing Sinatra framework
#

require 'json'
require 'sinatra'

class ToDo < Sinatra::Base


  def initialize

    # do NOT forget call always Sinatra::Base initialize
    super()

    text = File.read("tareas.txt")

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

        end

      end

      puts @ended

      erb :cast

   end

end
