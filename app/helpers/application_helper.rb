module ApplicationHelper

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column , :direction => direction}, {:class => css_class}
    #link_to title, :sort => column , :direction => direction, :class => css_class

  end

  def link_to_remove_fields(name)
    link_to name, 'javascript:;', class: 'remove-image'
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to name, 'javascript:;',"class" => 'add-image', "data-association" => "#{association}", "data-content" => "#{fields}"
  end





end
