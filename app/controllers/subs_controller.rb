class SubsController < ApplicationController
    def create
        @sub = Sub.new(sub_params)
        if @sub.save
            redirect_to new_assignments_path, alert: "Sub created"
        else
            redirect_to new_assignments_path, alert: "Sub not created"
        end
        
    end
    
    def sub_params
      params.require(:sub).permit(:comments, :created_at, :updated_at)
    end  
end