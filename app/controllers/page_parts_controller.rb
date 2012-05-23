class PagePartsController < ApplicationController
  before_filter :authenticate_admin_user!, :except => [:index, :show]
  # GET /page_parts
  # GET /page_parts.json
  def index
    @page_parts = PagePart.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @page_parts }
    end
  end

  # GET /page_parts/1
  # GET /page_parts/1.json
  def show
    @page_part = PagePart.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page_part }
    end
  end

  # GET /page_parts/new
  # GET /page_parts/new.json
  def new
    @page_part = PagePart.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page_part }
    end
  end

  # GET /page_parts/1/edit
  def edit
    @page_part = PagePart.find(params[:id])
  end

  # POST /page_parts
  # POST /page_parts.json
  def create
    @page_part = PagePart.new(params[:page_part])

    respond_to do |format|
      if @page_part.save
        format.html { redirect_to @page_part, notice: 'Page part was successfully created.' }
        format.json { render json: @page_part, status: :created, location: @page_part }
      else
        format.html { render action: "new" }
        format.json { render json: @page_part.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /page_parts/1
  # PUT /page_parts/1.json
  def update
    @page_part = PagePart.find(params[:id])

    respond_to do |format|
      if @page_part.update_attributes(params[:page_part])
        format.html { redirect_to @page_part, notice: 'Page part was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @page_part.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /page_parts/1
  # DELETE /page_parts/1.json
  def destroy
    @page_part = PagePart.find(params[:id])
    @page_part.destroy

    respond_to do |format|
      format.html { redirect_to page_parts_url }
      format.json { head :ok }
    end
  end
end
