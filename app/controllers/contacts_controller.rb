#encoding: utf-8
class ContactsController < InheritedResources::Base
  before_filter :authenticate_admin_user!, :except => [:show, :new, :create]

  def create
    if params[:contact][:name].blank?
      return
    end
    flash[:notice] = "信息提交成功！ 请等待我们的联系."
    super
  end
end
