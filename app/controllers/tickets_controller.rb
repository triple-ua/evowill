class TicketsController < ApplicationController
  def index
    @tickets = Ticket.all
  end

  def show
    @well_known_text = Ticket.find(params[:id]).well_known_text
  end
end
