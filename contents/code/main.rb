# <Copyright and license information goes here.>
require 'plasma_applet'
require 'singleton'
require 'rubygems'
require 'nokogiri'
require 'open-uri'

class  Lunch
  include Singleton

  def self.restaurants
    doc = Nokogiri::HTML(open('http://www.uniresta.fi/2010/ravintolat.php'))
    doc.search('div.sisalto_linkit tr:nth-child(2) a').inject({}) do |h,l|
      h[l.content] = l.attr(:href).match(/ravintola=([0-9]+)/)[1]
      h
    end
  end
end

module UnirestaPlasmoid


  class Main < PlasmaScripting::Applet
    def initialize(parent)
      super parent
    end

    def init
      self.has_configuration_interface = false

      restaurant = Plasma::ComboBox.new self
      Lunch.restaurants.keys.sort{|a,b|a<=>b}.each do |r|
        restaurant.add_item r
      end

      layout = Qt::GraphicsLinearLayout.new Qt::Vertical, self
      self.layout = layout
      layout.add_item restaurant
    end

  end
end
