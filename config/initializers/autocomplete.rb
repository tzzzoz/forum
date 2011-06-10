module Rails3JQueryAutocomplete

  module ClassMethods
    def autocomplete(object, method, options = {})

      define_method("autocomplete_#{object}_#{method}") do

        # term = params[:term]
        
        # split it
        topics = ActsAsTaggableOn::TagList.from(params[:term])
        
        term = topics[-1]

        if term && !term.empty?
          items = get_items(:model => get_object(object), \
            :options => options, :term => term, :method => method) 
        else
          items = {}
        end

        render :json => json_for_autocomplete(items, options[:display_value] ||= method)
      end
    end
  end

end
