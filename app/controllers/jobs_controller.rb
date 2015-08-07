class JobsController < ApplicationController
  before_action :find_job, only: [:show, :edit, :update, :destroy]
  
  def index
    if params[:category].blank?
      @jobs = Job.all.order("created_at DESC")
    else
      @category_id = Category.find_by(name: params[:category]).id
      @jobs = Job.where(category_id: @category_id).order("created_at DESC")
    end
  end
  
  def show
  end
  
  def new
    @jobs = Job.new
  end
  
  def create
    @jobs = Job.new(job_params)
    if @jobs.save
      redirect_to @jobs
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @jobs.update(job_params)
      redirect_to @jobs
    else
      render 'edit'
    end
  end
  
  def destroy
    @jobs.destroy
    redirect_to root_path
  end
  
  
  private
  
    def job_params
      params.require(:job).permit(:title, :description, :company, :url,
                                  :category_id)
    end
    
    def find_job
      @jobs = Job.find(params[:id])
    end
    
end
