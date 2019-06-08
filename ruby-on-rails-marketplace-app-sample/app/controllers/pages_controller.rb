class PagesController < HighVoltage::PagesController
  layout "application_fullscreen", only: [:index, :show]
end
