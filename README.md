# Chartkick

Create beautiful Javascript charts with one line of Ruby. No more fighting with charting libraries!

[See it in action](http://ankane.github.io/chartkick/)

Works with Rails, Sinatra and most browsers (including IE 6)

## Charts

Line chart

```erb
<%= line_chart User.group_by_day(:created_at).count %>
```

Pie chart

```erb
<%= pie_chart Goal.group(:name).count %>
```

Column chart

```erb
<%= column_chart Task.group_by_hour_of_day(:created_at, format: "%l %P").count %>
```

Bar chart

```erb
<%= bar_chart Shirt.group(:size).sum(:price) %>
```

Area chart

```erb
<%= area_chart Visit.group_by_minute(:created_at).maximum(:load_time) %>
```

Geo chart

```erb
<%= geo_chart Medal.group(:country).count %>
```

Timeline

```erb
<%= timeline [
  ["Washington", "1789-04-29", "1797-03-03"],
  ["Adams", "1797-03-03", "1801-03-03"],
  ["Jefferson", "1801-03-03", "1809-03-03"]
] %>
```

Multiple series

```erb
<%= line_chart @goals.map{|goal|
    {name: goal.name, data: goal.feats.group_by_week(:created_at).count}
} %>
```

or

```erb
<%= line_chart Feat.group(:goal_id).group_by_week(:created_at).count %>
```


### Options

Id and height

```erb
<%= line_chart data, id: "users-chart", height: "500px" %>
```

Min and max values

```erb
<%= line_chart data, min: 1000, max: 5000 %>
```

`min` defaults to 0 for charts with non-negative values. Use `nil` to let the charting library decide.

Colors

```erb
<%= line_chart data, colors: ["pink", "#999"] %>
```

Stacked columns or bars

```erb
<%= column_chart data, stacked: true %>
```

Discrete axis

```erb
<%= line_chart data, discrete: true %>
```

You can pass options directly to the charting library with:

```erb
<%= line_chart data, library: {backgroundColor: "#eee"} %>
```

See the documentation for [Google Charts](https://developers.google.com/chart/interactive/docs/gallery) and [Highcharts](http://api.highcharts.com/highcharts) for more info.

### Global Options

To set options for all of your charts, create an initializer `config/initializers/chartkick.rb` with:

```ruby
Chartkick.options = {
  height: "400px",
  colors: ["pink", "#999"]
}
```

Customize the html

```ruby
Chartkick.options[:html] = '<div id="%{id}" style="height: %{height};">Loading...</div>'
```

You capture the javascript in a content block with:

```ruby
Chartkick.options[:content_for] = :charts_js
```

Then, in your layout:

```erb
<%= yield :charts_js %> <%# Rails %>
<%= yield_content :charts_js %> <%# Padrino %>
```

This is great for including all of your javascript at the bottom of the page.

### Data

Pass data as a Hash or Array

```erb
<%= pie_chart({"Football" => 10, "Basketball" => 5}) %>
<%= pie_chart [["Football", 10], ["Basketball", 5]] %>
```

For multiple series, use the format

```erb
<%= line_chart [
  {name: "Series A", data: series_a},
  {name: "Series B", data: series_b}
] %>
```

Times can be a time, a timestamp, or a string (strings are parsed)

```erb
<%= line_chart({20.day.ago => 5, 1368174456 => 4, "2013-05-07 00:00:00 UTC" => 7}) %>
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem "chartkick"
```

And add the javascript files to your views.  These files must be included **before** the helper methods, unless using the `:content_for` option.

For Google Charts, use:

```erb
<%= javascript_include_tag "//www.google.com/jsapi", "chartkick" %>
```

If you prefer Highcharts, use:

```erb
<%= javascript_include_tag "path/to/highcharts.js", "chartkick" %>
```

### For Sinatra

You must include `chartkick.js` manually.  [Download it here](https://raw.github.com/ankane/chartkick/master/app/assets/javascripts/chartkick.js)

```html
<script src="//www.google.com/jsapi"></script>
<script src="chartkick.js"></script>
```

### Localization

To specify a language for Google Charts, add:

```html
<script>
  var Chartkick = {"language": "de"};
</script>
```

**before** the javascript files.

## See
  * [Chartkick](https://github.com/ankane/chartkick/blob/master/README.md)
