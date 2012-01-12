class Users::RegistrationsController < Devise::RegistrationsController
    def edit
        @authentiocations = Authentication.find_all_by_user_id current_user.id
    end
end