class Users::RegistrationsController < Devise::RegistrationsController
    def edit
        @authentiocations = Authentication.all
    end
end