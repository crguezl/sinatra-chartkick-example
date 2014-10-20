require 'sinatra'
require 'sinatra/reloader' if development?
require 'chartkick'

template :layout do
  <<LAYOUT
<html>
  <head>
    <script src="http://www.google.com/jsapi"></script>
    <script src="chartkick.js"></script>
  </head>
  <body>
    <%= yield %>
  </body>
</html>
LAYOUT
end

template :index do
  <<INDEX
    <%= pie_chart({"Football" => 10, "Basketball" => 5}) %>
INDEX
end

get '/' do
  erb :index
end
__END__
