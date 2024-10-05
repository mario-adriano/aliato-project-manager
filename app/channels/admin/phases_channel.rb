class Admin::PhasesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "admin_phases_channel"
  end

  def unsubscribed
  end
end
