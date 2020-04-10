
require 'chinese_name'
class HomeController < ApplicationController
  
  
  def index

    render json: 10.times.map {
      g = ChineseName.generate
     g.full_name}
  end
end
