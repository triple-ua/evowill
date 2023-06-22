class ConsumerController < ApplicationController
  def json
    ticket = Ticket.create!(ticket_params)
    Excavator.create!(excavator_params.merge(ticket_id: ticket.id))
  rescue StandardError => e
    render json: { 'error' => e.message }, status: :unprocessable_entity
  end

  render json: { 'message' => 'ok' }, status: :ok
end

private

def ticket_params
  underscore_keys

  ticket_params = params.permit([
    :request_number,
    :sequence_number,
    :request_type,
    :request_action,
    date_times: [
      :response_due_date_time
    ],
    service_area: [
      primary_service_area_code: [
        :sa_code
      ],
      additional_service_area_codes: [
        sa_code: []
      ]
    ],
    excavation_info: [
      digsite_info: [
        :well_known_text
      ]
    ]
  ])

  ticket_params[:response_due_date_time] = ticket_params[:date_times].delete(:response_due_date_time)
  ticket_params[:well_known_text] = ticket_params[:excavation_info][:digsite_info].delete(:well_known_text)
  ticket_params[:primary_service_area_code] = ticket_params[:service_area][:primary_service_area_code].delete(:sa_code)
  ticket_params[:additional_service_area_codes] = ticket_params[:service_area][:additional_service_area_codes].delete(:sa_code)

  ticket_params.reject! { |_k, v| v.is_a?(ActionController::Parameters) || v.blank? }
end

def excavator_params
  underscore_keys

  excavator_params = params.require(:excavator).permit(:company_name, :address, :city, :state, :zip, :crew_onsite)

  excavator_params[:address] = %i[address city state zip].map! do |p|
    excavator_params.delete(p)
  end.join(', ')

  excavator_params
end

def underscore_keys
  params.deep_transform_keys!(&:underscore)
end
