require 'css_parser'
require 'json'

include CssParser

## OUTPUTS
FILENAME = 'iconpicker-6.5.1.json'
DIRPATH = 'dist'

# Init a CssParser
all_parser = CssParser::Parser.new
brands_parser = CssParser::Parser.new

# Load the local CSS file, setting the base_dir and media_types
# Copy just the icon selectors from all.css and place into icons.css
all_parser.load_file!('all.css', 'dist/fontawesome-pro-6.5.1-web/css', :screen)
# Load the local CSS file, setting the base_dir and media_types
# brands_parser.load_file!('brands.css', 'dist/fontawesome-pro-6.0.0-beta2/css', :screen)

# Filter by a selector and media type
all_parser.find_by_selector('.fa-', [:all])
#brands_parser.find_by_selector('.fa-', [:all])

# In: '.fa.fa-pulse::before'
# Out: 'fa fa-pulse'
def clean_selector_for_json(selector)
  s = selector
  s = s.split("::")[0]
  s = s.split(":")[0]
  s = s.split(".")
  s = "#{s[1]} #{s[2]}".strip
end

def reject_icon?(icon)
  reject = false

  # Handle blacklisted selectors
  blacklist = File::readlines('./blacklisted_selectors.txt', chomp: true)
  if blacklist.include?(".#{icon}")
    puts "Blacklisted: #{icon}"
    reject = true
  end

  reject
end

def clean_array(icons)
  clean_array = Array.new
  icons.each do |icon|
    clean_array << icon unless reject_icon?(icon)
  end

  clean_array = clean_array.reject{|entry| entry.include?('fad')}
  clean_array = clean_array.reject{|entry| entry.include?('fa-duotone')}
  clean_array.uniq.sort
end

def prepare_hash(array)
  collection = Hash.new
  array.each_with_index do |entry, index|
    collection["#{index}"] = "#{entry}"
  end

  collection
end

icons = Array.new
all_parser.each_selector(:all) do |selector, _d, _s|
  icons << selector
end

brand_icons = Array.new
brands_parser.each_selector(:all) do |selector, _d, _s|
  brand_icons << selector
end

clean_icons = Array.new
icons.each do |icon|
  clean_icons << clean_selector_for_json(icon)
end
icons = clean_array(clean_icons)
icons = icons.map{|i| "fa-regular #{i}"}

clean_brand_icons = Array.new
brand_icons.each do |icon|
  clean_brand_icons << clean_selector_for_json(icon)
end

brand_icons = clean_array(clean_brand_icons)
brand_icons = brand_icons.map{|i| "fa-brands #{i}"}

all_icons = Array.new
all_icons << icons.drop(1)
all_icons << brand_icons.drop(1)
all_icons = all_icons.flatten
all_icons = prepare_hash(all_icons)

File.open("#{DIRPATH}/#{FILENAME}","w") do |f|
  f.write(JSON.pretty_generate(all_icons))
end
