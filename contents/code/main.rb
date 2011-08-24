# <Copyright and license information goes here.>
require 'plasma_applet'

module UnirestaPlasmoid
  class Main < PlasmaScripting::Applet
    def initialize parent
      super parent
    end

    def init
      self.has_configuration_interface = false
      self.aspect_ratio_mode = Plasma::Square
    end

    def paintInterface(painter, option, rect)
      painter.save
      painter.pen = Qt::Color.new Qt::black
      painter.draw_text rect, Qt::AlignVCenter | Qt::AlignHCenter, "Hello Ruby!"
      painter.restore
    end
  end
end
