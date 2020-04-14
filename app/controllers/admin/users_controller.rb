class Admin::UsersController < Admin::BaseController
  load_and_authorize_resource

  def index
    @users = User.by_username_email_or_document_number(params[:search]) if params[:search]
    @users = @users.page(params[:page])

    @active_users = User.active.by_username_email_or_document_number(params[:search]) if params[:search]
    @active_users = @users.active.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end
end
