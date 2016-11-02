class FacilitiesController < ApplicationController
    def new
        @facility = Facility.new
        times = ["12:00 AM"] + (1..11).map {|h| "#{h}:00 AM"}.to_a + ["12:00 PM"] + (1..11).map {|h| "#{h}:00 PM"}.to_a
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
        if params.key?(:assignments_week_id)
            @chosen_week = params[:assignments_week_id]
        else
            if @weeks.length > 0
                @chosen_week = @weeks[0][1]
            else
                @chosen_week = 0
            end    
        end
        @facility_hash = @facility.assignments_hash(@chosen_week)
    end
    
    def facility_params
       params.require(:facility).permit(:name, :ppl_per_shift, :su_start, :su_end, :m_start, :m_end, :tu_start, :tu_end, :w_start, :w_end, :th_start, :th_end, :f_start, :f_end, :sa_start, :sa_end)
    end    
end
