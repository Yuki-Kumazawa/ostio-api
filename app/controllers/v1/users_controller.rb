module V1
  class UsersController < ApplicationController
    before_filter :check_sign_in, except: [:index, :show]
    before_filter :check_permissions, except: [:index, :show, :show_current]

    def check_permissions
      not_authorized unless current_user == @user
    end

    # GET /users/1
    # GET /users/1.json
    def show
      @user = User.find_by_login!(params[:id])
    end

    def show_current
      render json: current_user
    end

    # PATCH/PUT /users/1
    # PATCH/PUT /users/1.json
    def update
      @user = User.find_by_login!(params[:id])

      if @user.update_attributes(params[:user])
        head :no_content
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    # DELETE /users/1
    # DELETE /users/1.json
    def destroy
      @user = User.find_by_login!(params[:id])
      @user.destroy

      head :no_content
    end
  end
end
