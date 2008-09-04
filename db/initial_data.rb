#See /lib/initial_data.rb for info on how this works
create_user(:cmsadmin, :login => "cmsadmin", :email => "cmsadmin@example.com", :password => "cmsadmin", :password_confirmation => "cmsadmin")

create_section(:root, :name => "My Site")
create_section(:products, :name => "Products", :parent => sections(:root))
create_section(:browsercms, :name => "BrowserCMS", :parent => sections(:products))
create_section(:browserams, :name => "BrowserAMS", :parent => sections(:products))
create_section(:about, :name => "About", :parent => sections(:root))
create_section(:people, :name => "People", :parent => sections(:about))
create_section(:careers, :name => "Careers", :parent => sections(:about))

create_page_template(:main, :name => "Main", :file_name => "main", :language => "haml", :body => "!!!\r\n%html\r\n  %head\r\n    %title= yield :title\r\n    = stylesheet_link_tag 'cms'\r\n    = yield :html_head\r\n  %body\r\n    = cms_toolbar\r\n    = container :main")
create_page_template(:two_column, :name => "Two Column", :file_name => "two_column", :language => "haml", :body=> "!!!\r\n%html\r\n  %head\r\n    %title= yield :title\r\n    = stylesheet_link_tag 'cms'\r\n    = yield :html_head    \r\n  %body\r\n    = cms_toolbar\r\n    %table{:width => 960}\r\n      %tr\r\n        %td{:width => 720}\r\n          = container :main\r\n        %td{:width => 240}\r\n          = container :sidebar")

create_page(:home, :name => "Home", :path => "/", :section => sections(:root), :template => page_templates(:two_column))
create_page(:about, :name => "About Us", :path => "/about", :section => sections(:about), :template => page_templates(:two_column))
create_page(:kerry, :name => "Kerry Gunther", :path => "/people/kerry", :section => sections(:people), :template => page_templates(:two_column))
create_page(:pat, :name => "Patrick Peak", :path => "/people/pat", :section => sections(:people), :template => page_templates(:two_column))
create_page(:paul, :name => "Paul Barry", :path => "/people/paul", :section => sections(:people), :template => page_templates(:two_column))

create_html_block(:hello_world, :name => "Hello World", :content => "<h1>Hello, World!</h1>")
create_html_block(:sidebar, :name => "Sidebar", :content => "<ul><li><a href=\"/\">Home</a></li><li><a href=\"/about\">About Us</a></li></ul>")
create_html_block(:about_us, :name => "About Us", :content => "We are super fantastic")

create_connector(:home_main, :page => pages(:home), :container => "main", :content_block => html_blocks(:hello_world))
create_connector(:home_sidebar, :page => pages(:home), :container => "sidebar", :content_block => html_blocks(:sidebar))
create_connector(:about_main, :page => pages(:about), :container => "main", :content_block => html_blocks(:hello_world))
create_connector(:about_sidebar, :page => pages(:about), :container => "sidebar", :content_block => html_blocks(:sidebar))

create_content_type(:html_block, :name => "HtmlBlock", :label => "Html Block")
create_content_type(:portlet, :name => "Portlet", :label => "Portlet")

create_portlet_type(:recently_updated_pages,
  :name => 'Recently Updated Pages',  
  :form => ".field\n  = f.label :name\n  = f.text_field :name\n.field\n  = f.label :number_of_pages\n  = f.text_field :number_of_pages, :size => 2",
  :code => "@pages = Page.all(:order => 'updated_at desc', :limit => @portlet.number_of_pages)",
  :template => "%h2 Recent Updates\n%ul\n  - @pages.each do |page|\n    %li=h page.name\n"
)
