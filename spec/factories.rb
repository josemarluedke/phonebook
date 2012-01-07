# encoding: utf-8
require 'factory_girl'

FactoryGirl.define do
    factory :user do
        name 'Josemar Davi Luedke'
        email 'josemarluedke@gmail.com'
        password 'josemar'
        password_confirmation 'josemar'
    end
   
    factory :authentication do
        provider 'facebook'
        uid '1570732973'
        association :user, :factory => :user
    end
    
    factory :group do
        name "Work"
    end
    
    factory :contact do
        name "Josemar Davi Luedke"
        email "josemarluedke@gmail.com"
        phone "51 55555555"
        cell  "51 99999999"
        obs "Tests"
        birthday Time.now
        twitter "@JosemarLuedke"
        im "josemarluedke@gmail.com"
        im_type "Google Talk"
        street "Pedro"
        city "Parobé"
        zip_code "95630-000"
        country "Brazil"
        association :user, :factory => :user
        association :group, :factory => :group
    end
end