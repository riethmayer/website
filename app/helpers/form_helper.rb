module FormHelper
  def admin_form_for(object, &p)
    form_for(object, :builder => AdminFormBuilder, &p)
  end
  
  def yui_sidebar_styles( opts = {} )
     select("page", "sidebar_class", Page.legal_sidebar_classes, opts) 
  end
end
