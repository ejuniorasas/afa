class FamiliesController < ApplicationController
  before_action :set_family, only: [:show, :edit, :update, :destroy]

  # GET /families
  # GET /families.json
  def index
    @families = Family.all
  end

  # GET /families/1
  # GET /families/1.json
  def show
  end

  # GET /families/new
  def new
    @family = Family.new
  end

  # GET /families/1/edit
  def edit
  end

  # POST /families
  # POST /families.json
  def create
    @family = Family.new(family_params)
    addMembers
    respond_to do |format|
      if @family.save
        format.html { redirect_to @family, notice: 'Family was successfully created.' }
        format.json { render :show, status: :created, location: @family }
      else
        format.html { render :new }
        format.json { render json: @family.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /families/1
  # PATCH/PUT /families/1.json
  def update
    addMembers
    respond_to do |format|
      if @family.update(family_params)
        format.html { redirect_to @family, notice: 'Family was successfully updated.' }
        format.json { render :show, status: :ok, location: @family }
      else
        format.html { render :edit }
        format.json { render json: @family.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /families/1
  # DELETE /families/1.json
  def destroy
    @family.destroy
    respond_to do |format|
      format.html { redirect_to families_url, notice: 'Family was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_family
      @family = Family.includes(members:[:contacts]).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def family_params
      params.require(:family).permit(:name, :status)
    end

    # Parameters: {"family"=>{"name"=>"alves", "members"=>[{"name"=>"silva", "last_name"=>"junior", "relation"=>"", "doc"=>"", "course"=>"", 
    # "contacts"=>[{"type"=>"phone", "content"=>"aaaaa"}]}]}}
    def member_params member
      member.permit(:name, :last_name, :relation, :doc, :course)
    end

    def contact_param contact
      contact.permit(:type, :content)      
    end

    def addMembers
      members = params[:family][:members]
      all_members = []

      members.each do |member|
        all_contacts = addContacts(member[:contacts])
        member_new = Member.new(member_params(member))
        member_new.contacts = all_contacts
        member_new.save
        all_members.push(member_new)
      end
      @family.members = all_members
    end

    def addContacts contacts
      db_contatct = []
      contacts.each do |contact|
        db_contatct.push(Contact.create!(contact_param(contact)))
      end
      db_contatct
    end
    
end
