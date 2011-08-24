# <Copyright and license information goes here.>
require 'plasma_applet'
require 'singleton'
require 'rubygems'
require 'hpricot'
require 'open-uri'

class  Lunch
  include Singleton

  def self.restaurants
    doc = Hpricot(open('http://www.uniresta.fi/2010/ravintolat.php'))
    doc.search('div.sisalto_linkit tr:nth-child(2) a').inject({}) do |h,l|
      h[l.at('span').inner_text] = l.attributes['href'].match(/ravintola=([0-9]+)/)[1]
      h
    end
  end

  def self.menu(id=1)
    doc = Hpricot(open("http://www.uniresta.fi/2010/ruokalista.php?ravintola=#{id}"))
    doc.search('div.sisalto_ravintolat table:nth-child(2) tr:nth-child(4) td').inject("") do |s,e|
      s = e.inner_html
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

      menu = Plasma::Label.new self
      restaurant = Plasma::ComboBox.new self
      @restaurants = Lunch.restaurants
      @restaurants.keys.sort{|a,b|a<=>b}.each do |r|
        restaurant.add_item r
      end
      restaurant.connect(SIGNAL('currentIndexChanged(int)')) do |i|
        menu.text = Lunch.menu(@restaurants[restaurant.text])
      end

      layout = Qt::GraphicsLinearLayout.new Qt::Vertical, self
      self.layout = layout
      layout.add_item restaurant
      layout.add_item menu
    end

  end
end
