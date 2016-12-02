class FacilitiesController < ApplicationController
    authorize_resource
    
    def new
        @facility = Facility.new
        times = get_all_times
        @start_times = ["Select Start Time"] + times
        @end_times = ["Select End Time"] + times
    end
    
    def create
        @facility = Facility.new(facility_params)
        if @facility.save
            redirect_to facilities_path(@facility.id), notice: "Facility created"
        else
            redirect_to new_facilities_path, alert: "Error creating facility."
        end
    end
    
    def show
        @facility = Facility.find(params[:format])
        @weeks = AssignmentsWeek.order(created_at: :desc).map{|item| [item.to_s, item.id]}
        @chosen_week = get_chosen_week(@weeks, params)
        @facility_hash = @facility.assignments_hash(@chosen_week)
    end
    
    def facility_params
       params.require(:facility).permit(:name, :ppl_per_shift, :su_start, :su_end, :m_start, :m_end, :tu_start, :tu_end, :w_start, :w_end, :th_start, :th_end, :f_start, :f_end, :sa_start, :sa_end)
    end    
end
