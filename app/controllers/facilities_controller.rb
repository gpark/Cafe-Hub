class FacilitiesController < ApplicationController
    def new
        @facility = Facility.new
        times = Array.new(24.hours / 30.minutes) {|i| [(Time.now.midnight + (i*30.minutes)).strftime("%I:%M %p"), (Time.now.midnight + (i*30.minutes)).strftime("%I:%M %p")]}
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
    end
    
    def facility_params
       params.require(:facility).permit(:name, :ppl_per_shift, :su_start, :su_end, :m_start, :m_end, :tu_start, :tu_end, :w_start, :w_end, :th_start, :th_end, :f_start, :f_end, :sa_start, :sa_end)
    end    
end
