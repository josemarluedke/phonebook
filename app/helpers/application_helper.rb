module ApplicationHelper
    def dispatcher_tag # https://github.com/fnando/dispatcher-js
        controller_name = controller.class.name.underscore
        controller_name.gsub!(/\//, "_")
        controller_name.gsub!(/_controller$/, "")

        raw %[<meta name="page" content="#{controller_name}##{controller.action_name}" />]
    end
    
    def nbsp
        raw("&nbsp;")
    end
end
